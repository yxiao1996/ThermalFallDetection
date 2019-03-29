function denoised = Markov1stDenoise(seq,numSteps)
%MARKOV1STDENOISE 
    % use markov 1st order model to denoise image sequence
    M = Markov1stOrder(1,0,1); % initialize Markov model
    numFrames = size(seq,1);
    denoised = zeros(size(seq));
    for i = 1:numFrames
        f = squeeze(seq(i,:,:));
        M = M.setImage(f);
        df = M.ICM(numSteps);
        denoised(i,:,:) = df;
    end
end

