classdef knnMultiClass
    %KNNMULTICLASS 
    % multiclass k-nearest neighbor classifier
    % training data input should be a cell array with m entires
    properties
        TrainData % taining dataset concatenating all samples
        k  % number of neighbors for classification
        m  % total number of classes
        numSamples % number of samples for each class
        intervals  % intervals for each class
    end
    
    methods
        function obj = knnMultiClass(k,m,train)
            %KNNMULTICLASS 
            obj.k = k;
            obj.m = m;
            % find the total number of training samples
            numRows = size(train{1},2);
            numCols = size(train{1},3);
            numSamples = zeros(m,1);
            for i = 1:m
                t = train{i};
                numSamples(i) = size(t,1);
            end
            numTotal = sum(numSamples);
            obj.numSamples = numSamples;
            obj.TrainData = zeros(numTotal,numRows,numCols);
            % copy all training sample into TrainData
            idx = 1;
            for i = 1:m
                c = train{i};
                for j = 1:numSamples(i)
                    s = squeeze(c(j,:,:));
                    obj.TrainData(idx,:,:) = s;
                    idx = idx + 1;
                end
            end
            % compute intervals for each class
            obj.intervals = zeros(m,2);
            obj.intervals(1,:) = [1 numSamples(1)];
            for i = 2:m
                st = obj.intervals(i-1,2) + 1;
                ed = st + numSamples(i) - 1;
                obj.intervals(i,:) = [st ed];
            end
            
        end
        
        function y = classify(obj,x)
            dists = zeros(size(obj.TrainData,1),1);
            for i = 1:size(obj.TrainData,1)
                x_train = squeeze(obj.TrainData(i,:,:));
                dists(i) = obj.EuclidDistance(x,x_train);
            end
            max_val = max(dists);
            consensus = zeros(obj.k,1);
            for i = 1:obj.k
                min_val = min(dists);
                min_idx = find(dists==min_val);
                % find which interval does this index falls in
                for j = 1:obj.m
                    intvl = obj.intervals(j,:);
                    st = intvl(1); ed = intvl(2);
                    if((min_idx(1)>=st) && (min_idx(1)<=ed))
                        consensus(i) = j;
                        dists(min_idx) = max_val;
                        break;
                    end
                end
            end
            % find the prefered class be consensus
            numVotes = zeros(obj.m,1);
            for i = 1:obj.m
                numVotes(i) = length(find(consensus==i));
            end
            maxVote = max(numVotes);
            maxClass = find(numVotes==maxVote);
            y = maxClass(1);
        end
        
        function acc = test(obj,feats,class)
            numPoint = size(feats,1);
            count = 0;
            for i = 1:numPoint
                x = squeeze(feats(i,:,:));
                y = obj.classify(x);
                if (y == class)
                    count = count + 1;
                end
            end
            acc = count / numPoint;
        end
        
        function d = EuclidDistance(obj,x1,x2)
            vec = x2(:) - x1(:);
            d = sqrt(dot(vec,vec));
        end
    end
end

