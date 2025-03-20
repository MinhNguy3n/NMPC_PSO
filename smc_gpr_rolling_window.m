clear all;
clc;

tic;

function y = sat(s,phi)
	if (abs(s/phi) < 1)
		y = s/phi;
	else
		y = s/abs(s);
    end
end

function y = edo(t, xp, x, u) 
	m = 1.2; 
	c = 0.4;
    g = 9.81;
	y = (u - c*xp*abs(xp) - m*g)/m;
end

function [xp,x] = rk4_2(t,h,u,xp,x)
	k11 = h*edo(t, xp, x, u);
	k12 = h*xp;
	k21 = h*edo(t + h/2, xp + k11/2, x + k12/2, u);
	k22 = h*(xp + k11/2);
	k31 = h*edo(t + h/2, xp + k21/2, x + k22/2, u);
	k32 = h*(xp + k21/2);
	k41 = h*edo(t + h, xp + k31, x + k32, u);
	k42 = h*(xp + k31);
	xp = xp + (k11 + 2*k21 + 2*k31 + k41)/6;
	x = x + (k12 + 2*k22 + 2*k32 + k42)/6;
end

ti = 0;
tf = 60;
csr = 100;
cst = 1/csr;
ssr = 200;
sst = 1/ssr;
t = ti:cst:tf;

jf = uint64(tf*csr+1);%converter para inteiro
kf = uint64(ssr/csr);

z = zeros(1,jf);
zp = zeros(1,jf);
y = 0.6;
yp = 0;
u = 0.0;

m_est = 1.0;
g = 9.81;
lambda = 0.8;
eta = 3.0;
phi = 0.1;

ds = 0.0;
std_ds = 0.0;
sigma_n = 0.2;
ell = 0.02;
n = 1;
Nw = 100;

fl_gpr = 1.0;%0.0 if without gpr

for j = 1:jf
    z(j) = y;
    zp(j) = yp;
    zd = 0.5*(1 - cos(0.1*pi*t(j)));
    zdm(j) = zd;
    zpd = 0.5*0.1*pi*sin(0.1*pi*t(j));
    zpdm(j) = zpd;
    zppd = 0.5*0.01*pi*pi*cos(0.1*pi*t(j));
    e(j) = z(j) - zd;
    ep(j) = zp(j) - zpd;
    s(j) = ep(j) + lambda*e(j);

    if fl_gpr == 1.0
        if n <= Nw
            Yp(n) = s(j);
            d(n) = m_est*edo(t(j), zp(j), z(j), u(max(1,j-1))) + m_est*g - u(max(1,j-1)) + sigma_n*randn(1); %"fake" desired output
        else
            Yp = circshift(Yp, -1);
            d = circshift(d, -1);
            Yp(Nw) = s(j);
            d(Nw) = m_est*edo(t(j), zp(j), z(j), u(max(1,j-1))) + m_est*g - u(max(1,j-1)) + sigma_n*randn(1); %"fake" desired output
        end
        k_XX = exp(-bsxfun(@minus,Yp',Yp).^2/(2*ell^2)); %matrix of covarience NxN - using all the training set
        aux = inv(k_XX + sigma_n^2*eye(min(n,Nw))); %inverse of covariance matrix with term to avoid det(x) = 0
        k_xX = exp(-bsxfun(@minus,s(j)',Yp).^2/(2*ell^2)); %vector that relates the input and training set
        ds = k_xX*aux*d'; %eq. 2.23
        std_ds = sqrt(1 - k_xX*aux*k_xX');%eq. 2.24 - taking square root to calculate standard deviation
    end
    vds(n)=ds;
    vstd_ds(n) = std_ds;

    kappa = eta + fl_gpr*(2*std_ds+abs(ds));
    u(j) = m_est*(zppd-lambda*ep(j)) + m_est*g - fl_gpr*ds - kappa*sat(s(j),phi);
    st = t(j);
    for k = 1:kf
      [yp,y] = rk4_2(st,sst,u(j),yp,y);
      st = st + sst;
    end

    n = n + 1;
end

% Create a 2x2 grid of subplots
figure;

% First subplot: Sine wave
subplot(2, 2, 1); % 2 rows, 2 columns, position 1
plot(t, z, 'r-', 'LineWidth', 1.0);
hold;
plot(t, zdm, 'b-', 'LineWidth', 1.0);
grid on;

% Second subplot: Cosine wave
subplot(2, 2, 2); % 2 rows, 2 columns, position 2
plot(t, e, 'r-', 'LineWidth', 1.0);
ylim([-0.2 0.6]);
grid on;

% Third subplot: Tangent wave
subplot(2, 2, 3); % 2 rows, 2 columns, position 3
plot(t, u, 'g-', 'LineWidth', 1.0);
grid on;

% Fourth subplot: Exponential
subplot(2, 2, 4); % 2 rows, 2 columns, position 4
plot(t, vds, 'm-', 'LineWidth', 1.0);
hold;
fill([t, fliplr(t)], [vds+2*vstd_ds, slidi(vds-2*vstd_ds)], 'b', ...
     'FaceAlpha', 0.2, 'EdgeColor', 'none');
grid on;

toc;