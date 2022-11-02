目的：复现fft2（因为matlab据说也是这么实现的）

编译命令：   mex -v fftw2.cpp -llibfftw3-3 -llibfftw3f-3 -llibfftw3l-3 -L"C:/Users/DELL/Desktop/homework" -R2018a
交叉编译环境：VC2019 
FFWT库官网：http://www.fftw.org/
调用函数fftw库函数：fftw_plan_dft_r2c_2d()
参考github：https://github.com/ucl-bug/matlab-dtts （这老爷子email不回复）
感觉问题：matlab的mxGetComplexDoubles的martix的数据结构和fft库的复数数据结构有差异。