classdef texture
    %TEXTURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
         function [I,I_rgb,I_gray] = normalize_image(I)
            % initialization: normalize image
            if isa(I,'uint8')
                I = double(I)/255;
            end
            if isa(I,'uint16')
                I = double(I)/65535;
            end
            if size(I,3)==3 % rgb image
                I_gray = repmat(rgb2gray(I),[1 1 3]);
                I_rgb = I;
            else % assuming grayscale image
                I_gray = repmat(I,[1,1,3]);
                I_rgb = I_gray;
            end
         end
        
         function init_label()
            global image LABELING;
            
            im_size = size(image);
            square_size = round(im_size./8);
            spot1 = round(im_size ./ 4);
            spot2 = round(im_size .* (0.75));
            
            for i = 1:square_size(1)
                for j = 1:square_size(2)
                    p1 = spot1 + [i j];
                    ix1 = p1(1)*im_size(2) + p1(2);
                    LABELING(ix1 , 1) = 1;
                    
                    p1 = spot2 + [i j];
                    ix1 = p1(1)*im_size(2) + p1(2);
                    LABELING(ix1 , 2) = 1;                    
                end
            end
         end
         
         function init_label_circle()
            global image LABELING;
            
            im_size = size(image);
            square_size = round(im_size./8);
            spot1 = round(im_size ./ 2);
            spot2 = round(im_size .* (0.75));
            
            for i = 1:square_size(1)
                for j = 1:square_size(2)
                    p1 = spot1 + [i j];
                    ix1 = p1(1)*im_size(2) + p1(2);
                    LABELING(ix1 , 1) = 1;
                    
                    p1 = spot2 + [i j];
                    ix1 = p1(1)*im_size(2) + p1(2);
                    LABELING(ix1 , 2) = 1;                    
                end
            end
         end
        
    end
    
end

