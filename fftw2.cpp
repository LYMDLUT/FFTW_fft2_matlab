#include "matrix.h"
#include <mex.h>
#include "fftw3.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    mxArray *output_mat;
    mwSize numelements;    
    const mwSize *dims;
    int NX, NY,NZ,numdims;
    double *input_ptr;
    fftw_complex  *output_ptr;
    fftw_plan plan;
    
    numdims = mxGetNumberOfDimensions(prhs[0]);
    if ( numdims != 2){
        mexErrMsgTxt("Input array must be 2D.");
    }
    if( !(mxIsDouble(prhs[0]) && !mxIsComplex(prhs[0])) ) {
        mexErrMsgTxt("Input array must be double precision and real.");
    }  
    
    //get the dimensions of the input array
    dims = mxGetDimensions(prhs[0]);
    numelements = mxGetNumberOfElements(prhs[0]);
    NX = (int) dims[0];
    NY = (int) dims[1];
    //create MATLAB output
    output_mat = plhs[0] = mxCreateDoubleMatrix(NX, NY, mxCOMPLEX);
    
    //get pointer to input and output arrays
    input_ptr = (double*) mxGetPr(prhs[0]);
    output_ptr = (fftw_complex*) mxGetComplexDoubles(output_mat);
    if(!(plan = fftw_plan_dft_r2c_2d(NY, NX, (double*) input_ptr, (fftw_complex*) output_ptr,FFTW_ESTIMATE))) 
        mexErrMsgTxt("FFTW3 failed to create plan.");  
    fftw_execute(plan);    
    fftw_destroy_plan(plan);
    return;
}