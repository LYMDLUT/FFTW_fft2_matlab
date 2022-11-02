% load image
image=imread('./images/Fig4.04(a).jpg');
image=im2double(image); %Image processing requires double precision
figure(1);
imshow(image,[]);
title('origin image');

% The original image matrix is expanded to obtain fp(x,y)
[M,N]=size(image);
P=2*M;
Q=2*N;
image_fp=zeros(P,Q);
image_fp(1:M,1:N)=image(1:M,1:N);

%(-1)^(x+y) Multiplied by fp(x,y) to Move it to the center
for x=1:P
    for y=1:Q
        image_fp(x,y)=image_fp(x,y).*(-1)^(x+y);
    end
end

% Take the two-dimensional Fourier transform of the image
image_F=fftw2(image_fp);

% Generate an ideal low-pass filter H(u,v)
image_H=zeros(P,Q);
D0=60;
for x=1:P
    for y=1:Q
        D=sqrt((x-M)^2+(y-N)^2);
        if D>D0
            image_H(x,y)=0;
        else
            image_H(x,y)=1;
        end
    end
end
figure(2);
imshow(image_H);
title('Ideal low-pass Filter');

% Multiply the arrays to get the product G(u,v)=H(u,v)*F(u,v)
image_G=image_H.*image_F;

% Find the IDFT of G and take its real part，then multiply(-1)^(x+y),
%he processed image is obtained gp(x,y)
image_gp=real(ifft2(image_G));
for x=1:P
    for y=1:Q
        image_gp(x,y)=image_gp(x,y).*(-1)^(x+y);
    end
end

% The final processing result g(x,y) is obtained by 
%extracting the M*N region from the upper left quadrant of gp(x,y)
image_g=image_gp(1:M,1:N);
figure(3);
imshow(image_g,[]);
title('Final result');

% Draw the Fourier spectrum
R=real(image_F); %Extract the real component
I=imag(image_F); %Extract imaginary parts
image_F1=log(1+abs(image_F));
figure(4);
imshow(image_F1,[]);
title('Fourier transform amplitude spectrum');
figure(5);
image_F2=atan(I./R);
imshow(image_F2,[]);
title('Fourier transform phase spectrum');