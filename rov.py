# from IPython import get_ipython
# get_ipython().run_line_magic('reset', '-sf')

import numpy as np
import cmath
import matplotlib.pyplot as plt
import tensorflow_probability as tfp
import tensorflow.keras as keras

np.random.seed(123)

# plt.rcParams['text.usetex'] = True

def sin(x): 
    return np.sin(x)
def cos(x):
    return np.cos(x)
def tan(x):
    return np.tan(x)
def sqrt(x):
    return np.real(cmath.sqrt(x))

def sat(x):
    if abs(x) <= 1.0:
        return x
    else:
        return np.sign(x)

def F_term(Q,Qp,P):
    zp = Qp[0,0]
    
    c = P['c']
    
    F = np.zeros((1,1))
    F[0,0] = -c*zp*abs(zp)
    
    return F

def ode(t,P,Q,Qp,u):
    m = P['m']
    
    F = F_term(Q, Qp, P)
    Qpp = np.zeros((1,1))
    Qpp[0,0] = u[0,0] + F[0,0]
    
    Qpp[0,0] = Qpp[0,0]/m
    
    return Qpp

def call_ode(t, dt, u, Q, Qp, P):
    ka = dt*Qp
    kb = dt*ode(t, P, Q, Qp, u)
    
    return ka, kb

def rk4(t, dt, u, Q, Qp, P):
    k1a,k1b = call_ode(t, dt, u, Q, Qp, P)
    
    k2a,k2b = call_ode(t + dt/2, dt, u, Q + k1a/2, Qp + k1b/2, P)
    
    k3a,k3b = call_ode(t + dt/2, dt, u, Q + k2a/2, Qp + k2b/2, P)
    
    k4a,k4b = call_ode(t + dt, dt, u, Q + k3a, Qp + k3b, P)
    
    Q = Q + (k1a + 2*k2a + 2*k3a + k4a)/6
    Qp = Qp + (k1b + 2*k2b + 2*k3b + k4b)/6
    Qpp = ode(t, P, Q, Qp, u)
    
    return Q, Qp, Qpp

def update_ann(eta,s,dt,w,a,mu):
    if np.linalg.norm(w,2) < mu or (np.linalg.norm(w,2) == mu and eta*s*np.dot(w.T,a) < 0.0):
        w = w + eta*s*a*dt
    else:
        w = w + np.dot(np.eye(len(w)) - np.dot(w.reshape(-1,1),w.reshape(1,-1))/np.dot(w.T,w) ,eta*s*a*dt)
    return w

def ativ(x,c,w):
    return np.array([np.exp(-0.5*((x-c[i])/w[i])**2) for i in range(len(c))])

dt = 0.01
dtc = max(0.05,dt) #dtc with 0.02 is good 
t_end = 60.0
t = np.arange(0.0,t_end+dtc,dtc)

Q1 = np.zeros(len( t ))
Q1d = np.zeros(len( t ))
d_mean = np.zeros(len( t ))
d_std = np.zeros(len( t ))
u1 = np.zeros(len( t ))
s_ = np.zeros(len( t ))

P = {"c":250.0,"m":50.0}

P_est = P
P_est['m'] = 45.0

u = np.zeros((1,1))

Q = np.zeros((1,1))
Qp = np.zeros((1,1))
Qpp = np.zeros((1,1))

amp = 0.5
freq = 2.0*np.pi/15.0

d_est = np.zeros((1,1))

lam1 = 0.8
cam1 = 0.1
eta = 4.0

#GP
use_gpr = True
tfd = tfp.distributions
kernels = tfp.math.psd_kernels
type_gp = 'rolling window' #rolling window, accumulating
if type_gp == 'accumulating':
    X_train = np.array([]).reshape(-1,1)
    Y_train = np.array([]).reshape(-1,)
elif type_gp == 'rolling window':
    Nw = 500
    X_train = np.zeros(Nw).astype(np.float32).reshape(-1,1)
    Y_train = np.zeros(Nw).astype(np.float32).reshape(-1,)
ell = 0.05
sigma_n = 0.2
sigma_f = 1.0
kernel = kernels.ExponentiatedQuadratic(amplitude=sigma_f, length_scale=ell)

for tt in range(len( t )):
    z = Q[0,0]
    zp = Qp[0,0]
    zpp = Qpp[0,0]
    
    zd = amp*np.cos(freq*t[tt])
    zpd = -amp*freq*np.sin(freq*t[tt])
    zppd = -amp*freq*freq*np.cos(freq*t[tt])
    
    #controller
    e1 = z - zd
    e1p = zp - zpd
    s1 = e1p + lam1*e1
    
    if len(Y_train) > 0 and use_gpr:
        # print training set size
        print('Training set size: X = ', len(X_train), ' Y = ', len(Y_train))
        # print training set data
        print("Training set: X_train ", X_train)
        print("Training set: Y_train ", Y_train)

        gp_posterior = tfd.GaussianProcessRegressionModel(#calls tensorflow function for GPs
            kernel=kernel,
            index_points=np.array([s1]).reshape(-1, 1).astype(np.float32),
            observation_index_points=X_train,
            observations=Y_train,
            observation_noise_variance=sigma_n
        )
        mean_prediction = gp_posterior.mean().numpy()#mean of Gaussian distribution - main output - it is used to predict the unknown dynamics
        std_prediction = gp_posterior.stddev().numpy()#predicts the level of uncertainty about the Gaussian distribution
    else:
        mean_prediction = np.array([0.0])
        std_prediction = np.array([0.0])
    
    kappa = eta + 2.0*abs(std_prediction[0])
    u[0,0] = P_est['m']*(zppd - lam1*e1p) - kappa*sat(s1/cam1) - mean_prediction[0] #controller
    #######
    t_sim = np.arange(t[tt],t[tt] + dtc,dt)
    for ts in t_sim:
        Q, Qp, Qpp = rk4(ts, dt, u, Q, Qp, P)
        
    if use_gpr:
        dbar = P_est['m']*zpp - u[0,0] + sigma_n*np.random.normal(0.0, scale=1.0)
        if type_gp == 'accumulating':#if selected this option, the training set growns until the program stops
            X_train = np.vstack((s1,X_train)).astype(np.float32)
            Y_train = np.hstack((dbar,Y_train)).astype(np.float32)
        elif type_gp == 'rolling window':#if selected this option, the training set has a fixed size of length Nw.
            X_train = np.roll(X_train, axis=0, shift=-1)
            X_train[-1,0] = s1
            Y_train = np.roll(Y_train, axis=0, shift=-1)
            Y_train[-1] = dbar
            X_train = X_train.astype(np.float32)
            Y_train = Y_train.astype(np.float32)
    
    Q1[tt] = Q[0,0] #angle joint
    Q1d[tt] = zd #desired state
    d_mean[tt] = mean_prediction[0]
    d_std[tt] = std_prediction[0]
    u1[tt] = u[0,0] #torque
    s_[tt] = s1 #torque
    
    
fig = plt.figure(1)
fig.set_figheight(10)
fig.set_figwidth(15)

ax0 = plt.subplot2grid(shape=(2, 3), loc=(0, 0))
ax1 = plt.subplot2grid(shape=(2, 3), loc=(1, 0))
ax2 = plt.subplot2grid(shape=(2, 3), loc=(0, 1))
ax3 = plt.subplot2grid(shape=(2, 3), loc=(1, 1))
ax4 = plt.subplot2grid(shape=(2, 3), loc=(0, 2))
ax5 = plt.subplot2grid(shape=(2, 3), loc=(1, 2))
fig.tight_layout(pad=3.5)

ax0.plot(t, Q1, linewidth=1, c='blue')
ax0.plot(t, Q1d, linewidth=1, c='black')
ax0.set_xlabel(r'$t$ [s]', fontsize=18)
ax0.set_ylabel(r'$z$', fontsize=18)
ax0.set_title(r'Trajectory tracking')

ax1.plot(t, Q1-Q1d, linewidth=1, c='blue')
ax1.set_xlabel(r'$t$ [s]', fontsize=18)
ax1.set_ylabel(r'$\tilde{z}$', fontsize=18)
ax1.set_title(r'Tracking error')

ax2.plot(t, d_mean, linewidth=1, c='blue')
ax2.fill_between(t, 
                 d_mean - 2 * d_std, 
                 d_mean + 2 * d_std, 
                 alpha=0.2)
ax2.set_xlabel(r'$t$ [s]', fontsize=18)
ax2.set_ylabel(r'$\hat{d}$', fontsize=18)
ax2.set_title(r'GP output')

ax3.plot(t, s_, linewidth=1, c='blue')
ax3.set_xlabel(r'$t$ [s]', fontsize=18)
ax3.set_ylabel(r'$s$', fontsize=18)
ax3.set_title(r'GP input')

ax4.plot(t, u1, linewidth=1, c='blue')
ax4.set_xlabel(r'$t$ [s]', fontsize=18)
ax4.set_ylabel(r'$u$', fontsize=18)
ax4.set_title(r'Control effort')

plt.show()