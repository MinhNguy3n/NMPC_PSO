
#include "RNG.h"
#include <math.h>
#include <ap_int.h>


long unsigned int seed31pm  = 1;

// rand31-park-miller-carta.cc 
// ---------------------------       
//
// Robin Whittle  rw@firstpr.com.au    2005 September 21
//
// For more information and updates: http://www.firstpr.com.au/dsp/rand31/
//
// This code contains two separate implementations of the 1988 Park Miller
// "minimal standard"  31 bit PRNG (Pseudo-Random Number Generator):  
// 
// rand31pm   The conventional Park Miller "Integer Version 1" algorithm
//            but implemented rather slowly in double-precision floating 
//            point to ensure accuracy and portability.
//            
//            This is intended as a reference.
//
// rand31pmc  My own fast integer implementation of David G. Carta's
//            approach to this PRNG, using only 32 bit integer maths
//            and no divisions.
//
// My aim is to show that the two are functionally identical, to explain 
// Carta's implementation, and to provide code which can be used by others.  
//
// Please grab the rand31pmc class and use it in your own projects.  A 
// separate pair of .c and .h files are available for incorporation into 
// ANSI C projects.
//
// When running the C versions of the Carta implementation and the 
// plain floating point Park Miller aglorithm, on an 800MHz Pentium III with
// no compiler optimisation, the Carta version produced 13 million results a 
// second (61 CPU clock-cycles per result) and the floating point version 
// was about 1/4 this speed.
// 
// The two classes  below implement the same multiplicative linear 
// congruential PRNG (pseudo-random number generator).  This type of
// PRNG is not suitable for crytpography and does not produce sequences 
// long enough or random enough for most simulation purposes.  
//
// Most of the detailed analytical work on PRNGs has gone into those 
// suitable for crypto and simulation.  PRNGs well respected in these 
// fields - such as the Mersenne Twister for simulation - are slow, tricky, 
// or require excessive memory compared with a linear congruentual 
// generator.
//
// This leaves people who are searching for a fast, well studied, linear 
// congruential PRNG looking at a varied and often troublesome bunch of 
// stuff, including algorithms written up in textbooks or incorporated in 
// libraries, many of which produce poor results.  Since it can be hard to 
// recognise the problems in a PRNG, it is best to use one which is well 
// studied and respected.
//
// Unfortunately, linear congruential generators have many bad algorithms 
// and/or bad implementations.  Most publicly available implementations 
// of the good algorithms involve division.  (The major exception I know 
// of is Ray Gardner's rg_rand.c, which implements the Carta algorithm.)
//
//
// There is a widely used 32 bit integer implementation of Park-Miller's
// "minimal standard" PRNG, using Shrage's approach: Park Miller's 
// "Integer Version 2".  This requires a division.  I don't have this 
// implementation here.  The "Integer Version 1" implementation exists 
// to provide the reference sequence of pseudo-random numbers by which we 
// test the second implementation.
//
//
// The second class "rand31pmc" is functionally identical to, and was 
// inspired by, a snippet of C code by Ray Gardner which dates from as
// early as 1995 (according to Google searches in 2005): 
//
//   http://c.snippets.org/snip_lister.php?fname=rg_rand.c
//
// This cites Carta, and implements Carta's approach, but has no explanation
// of how this approach works.  Carta's paper contains a far more complex
// explanation than the one I give below.
//
// I don't have contact details for Ray Gardner, or any of the people 
// mentioned in the references.  Eric Raymond mentions he wrote some 
// hypertext-like code with Ray Gardner in the early 90s, and I think
// Ray Gardner may have moderated Usenet comp.lang.c.
//
// There are two important aims which are achieved both by David Carta's 
// algorithm, Ray Gardner's code and class "rand31pmc":
//
// 1 - The code can run with 32 bit math operations - including a 16 x 16
//     = 32 bit multiply.
//
// 2 - There is no need for a division.
//
// David Carta's 1990 paper gave no code examples. 
//
// Stephen K. Park and Keith W. Miller rejected Carta's algorithm in 
// 1993 "... the generator as implemented by Carta is ~not~ the minimal 
// standard; it isn't even a full-period generator.  We know of no good 
// reason to use Carta's generator."
//
// But here, by compiling and running this program, you can see that 
// David Carta's algorithm produces identical results to the Park Miller 
// algorithm.
// 
// Assuming Ray Gardner really did write his code (rather than copy
// it from somewhere else), my best guess is that he started off
// trying to implement Shrage's approach (as the comments and the
// unused Shrage-specific constants suggest) and then made his code
// do what David Carta suggested.  I guess that since it worked, 
// he left it at that, without updating the comments and constants.
//
// My explanation of why Carta's algorithm works is in the code, where it 
// belongs.  Please don't strip the comments out.  
//
// It is reasonable to expect that Carta's approach would run faster 
// than Shrage's approach in "Integer Version 2" - if only because
// there is no division.  
//
// My main interest here is proving that Carta's approach works 
// properly, because I want to implement it on CPUs such as the dsPIC 
// which have a slow divide.  Most CPUs have a slow divide anyway, as 
// far as I know, so if you are in a hurry, Carta's approach is 
// probably the best.
//
// References:
//
//    Stephen K. Park and Keith W. Miller 
//    Random Number Generators: Good Ones are Hard to Find
//    Communications of the ACM, Oct 1988, Vol 31 Number 10 1192-1201
//
//       Like the other two papers, this one is normally only available
//       from the ACM site via subscription.  You should be able to
//       access this paper electronically or in print at a university
//       library.  You may also be able to find the .PDF wild on the
//       Net.  Search for "p1192-park.pdf".  For instance:
//
//         http://www-scf.usc.edu/~csci105/links/p1192-park.pdf     
//
//    David F. Carta
//    Two Fast Implementations of the "Minimal Standard" Random Number Generator
//    Communications of the ACM, Jan 1990, Vol 33 Number 1 87-88  (p87-carta.pdf)
//
//    George Marsaglia; Stephen J. Sullivan; Stephen K. Park, Keith W. Miller, 
//    Paul K. Stockmeyer
//    Remarks on Choosing and Implementing Random Number Generators 
//    Communications of the ACM, Jul 1993, Vol 36 Number 7 105-110 (p105-crawford.pdf)
//
// The following code is public domain.  If you use this code, I request that 
// you keep the comments with it, to save some poor sod from having to figure 
// out the history behind it.  


//////////////////////////////////////////////////////////////////////////////
//
// rand31pm
//
// 31 bit Pseudo Random Number Generator based on Park Miller "Integer 
// Version 1" - but done with double-precision floating point so we are not 
// concerned with the limits of integer operations.  This is not intended for 
// fast operation - but *maybe* it would be faster than the integer 
// implementation on some CPUs.  
//  
// Methods:
//    
//    seedi    Set seed with a 31 bit unsigned integer between 1 and 
//             0x7FFFFFFE inclusive.  Don't use 0!
//
//    ranlui   Provides the next pseudorandom number as a long unsigned 
//             integer (31 bits).
//
//    ranf     Provides the next pseudorandom number as a float between
//             nearly 0 and nearly 1.0.

class rand31pm {
                                    // The sole item of state - a 32 bit 
                                    // integer.
    long unsigned int seed31;   

public:
                                    // Constructor sets seed31 to 1, 
                                    // in case no seedi operation is
                                    // used.
    rand31pm() {seed31 = 1;}                                    
                                    
                                    // Declare methods.
                                    
    void              seedi(long unsigned int);
    long unsigned int ranlui(void);  
    float             ranf(void);
    

private:
                                    // nextrand()
                                    //
                                    // Generate next pseudo-random number.
                                    
                                    // Multiplier constant = 16807 = 7^5.  
                                    // Park and Miller in 1993 recommend
                                    // 48271.
    #define consta 16807            
//  #define consta 48271            
                                    // Modulus constant = 2^31 - 1 =
                                    // 0x7FFFFFFFF.  Use .0 to deter compiler
                                    // from complaining about a very large 
                                    // integer constant.    
    #define constm 2147483647.0     
                                            
    long unsigned int nextrand()
    {
        double const a = consta;
        double const m = constm;
                                    // This is the linear congrentual 
                                    // generator:
                                    //  
                                    // Multiply the old seed by constant a 
                                    // and take the modulus of the result 
                                    // (the remainder of a division) by 
                                    // constant m.
                                    
        seed31 = (long)(fmod((seed31 * a), m));

        return (seed31);        
    }
};

                                    /////////////////////////////////////////
                                    //
                                    // Implementations of the methods.
                                    
                                    // seedi()
                                    //
                                    // Set the seed from a long unsigned 
                                    // integer.  If zero is used, then
                                    // the seed will be set to 1.
                                                                        
void rand31pm::seedi(long unsigned int seedin)
{
    if (seedin == 0) seedin = 1;
    seed31 = seedin;
}
                                    
                                    // ranlui()
                                    //
                                    // Return next pseudo-random value as
                                    // a long unsigned integer.
                                    
long unsigned int rand31pm::ranlui(void)  
{
    return nextrand();
}

                                    // ranf()
                                    //
                                    // Return next pseudo-random value as
                                    // a floating point value.
float rand31pm::ranf(void)  
{
    return (nextrand() / constm);
}


void RNG(unsigned &seedi, float &randFloat){
    rand31pm rand1pm;

    rand1pm.seedi(seedi);

    randFloat = rand1pm.ranf();

}
