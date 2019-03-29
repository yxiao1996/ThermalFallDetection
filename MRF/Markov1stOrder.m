classdef Markov1stOrder
    %MARKOV1STORDER 
    % 1st order Markov model for binary image denoising using ICM algorithm
    % (iterated conditional modes)
    % implementation based of book "Pattern Recognition and Machine Learning"
    % chapter 7 Markov random field
    
    properties
        h
        beta
        eta
        img
    end
    
    methods
        function obj = Markov1stOrder(h,beta,eta)
            %MARKOV1STORDER 
            obj.h = h;
            obj.beta = beta;
            obj.eta = eta;
        end
        
        function obj = setImage(obj,img)
            obj.img = img;
        end
        
        function denoised = ICM(obj,numSteps)
            % image denoising using ICM algorithm
            denoised = obj.img; % initialize as the noisy image
            numRows = size(obj.img,1);
            numCols = size(obj.img,2);
            for s = 1:numSteps % run many iterations
                % randomly pick a location to look at
                row = ceil(rand*(numRows-2)) + 1; % don't pick locations on edges
                col = ceil(rand*(numCols-2)) + 1;
                % calculate the energy when node (row,col) is 1 and 0
                denoised(row,col) = 1; % set node to 1
                E1 = obj.Energy(denoised,row,col);
                denoised(row,col) = 0; % set node to 0
                E2 = obj.Energy(denoised,row,col);
                % pick the lower energy choice
                if(E1 < E2)
                    denoised(row,col) = 1;
                end
            end
        end
        
        function E = Energy(obj,d,r,c)
            %E = obj.h*d(r,c) - obj.beta*d(r,c)*( ...
            %    d(r,c-1)+d(r,c+1)+d(r-1,c)+d(r+1,c)) ... % first order neighbors 
            %    - obj.eta*(obj.img(r,c)*d(r,c));
            E = obj.beta*( ...
                (d(r,c)-d(r,c-1))^2 + ...
                (d(r,c)-d(r,c+1))^2 + ...
                (d(r,c)-d(r-1,c))^2 + ...
                (d(r,c)-d(r+1,c))^2  ...
            );
        end
    end
end

