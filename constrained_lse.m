clear all 
inp_img_set = {'lena512.bmp', 'boats512_outoffocus.bmp', 'man512_outoffocus.bmp'};
noise_var = 0.0833;

%generate blur function
r = 8;
h = myblurgen('gaussian', r);

for idx = 1:numel(inp_img_set)
	if strcmp(inp_img_set(idx),'lena512.bmp') == 1
		inp_img_uint8 = imread(inp_img_set{idx});
        inp_img_dbl = double(inp_img_uint8);
        inp_img = padarray(inp_img_dbl,[8,8],'replicate',"both");
		blur_img_dbl = conv2(inp_img, h, 'same');
		blur_img_quantized = uint8(blur_img_dbl);
	else
		blur_img_quantized = imread(inp_img_set{idx});
        blur_img_quantized = padarray(blur_img_quantized,[8,8],'replicate',"both");
	end

	% call the deblurring algorithm
	deblur_process(h, blur_img_quantized, noise_var, idx);
	
end

function deblur_process(h, blur_img_dbl, noise_var, idx)

	%blur_img_uint8=padarray(blur_img_uint8,[8 8],0, 'both');
	blur_img_fft_dbl=fft2(blur_img_dbl);
    
	% padding for h
% 	h_pad = zeros(512);
% 	h_pad(1:17, 1:17) = h;
% 	
	% fft of h
	H_uv = fft2(h,528,528);
	H_uv_conj = conj(H_uv);
	%H_uv_abs2 = abs(H_uv).^2;
    H_uv_abs2 = H_uv.*H_uv_conj;
	
	% laplacian
	laplacian = [0 -1 0; -1 4 -1; 0 -1 0];
% 	lap_pad = zeros(512);
% 	lap_pad(1:3,1:3) = laplacian;
	lap_pad_fft = fft2(laplacian, 528, 528);
	lap_pad_abs2 = abs(lap_pad_fft).^2;
	
	% gamma values set
	%gamma = 0.001:0.001:0.009;
    %gamma = 0.011:0.001:0.12;
    gamma = 0.0005;
	
    figure(idx)
	%display blurred image
	subplot(1,2,1)
    blur_img_dbl_crop = blur_img_dbl(9:520, 9:520);
	imshow(uint8(blur_img_dbl_crop));
    title('blurred image');
	
	%constranied least sqaures for various gammas
	for i=1:numel(gamma)
		lse = H_uv_conj;
		lse = lse./(H_uv_abs2 + gamma*lap_pad_abs2);
		F_uv = lse .* blur_img_fft_dbl;
		restored = real(ifft2((F_uv)));
        restored_crop = restored(9:520, 9:520);
		subplot(1,2,i + 1)
		imshow(uint8(restored_crop))
		title(append('\gamma = ', num2str(gamma(i))));
	end

end