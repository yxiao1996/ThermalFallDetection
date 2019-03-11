classdef knn
    %KNN 
    % a K-Nearest-Neighbor model to classify images (2 classes)
    
    properties
        class1
        class2
        k
    end
    
    methods
        function obj = knn(class1,class2,k)
            %KNN 
            % Construct a KNN model
            obj.class1 = class1;
            obj.class2 = class2;
            obj.k = k;
        end
        
        function y = classify(obj,x)
            % classify new data point according to its neighbors
            numClass1 = size(obj.class1,1);
            numClass2 = size(obj.class2,1);
            train = cat(1,obj.class1,obj.class2);
            dists = zeros(size(train,1),1);
            for i = 1:size(train,1)
                x_train = train(i,:);
                x = x(:);
                dists(i) = obj.EclidDistance(x,x_train);
            end
            %disp(dists');
            max_val = max(dists);
            consensus = zeros(obj.k,1);
            for i = 1:obj.k
                min_val = min(dists);
                min_idx = find(dists==min_val);
                if (min_idx <= numClass1)
                    consensus(i) = 1;
                else
                    consensus(i) = 2;
                end
                dists(min_idx) = max_val;
            end
            num_1s = length(find(consensus == 1));
            num_2s = length(find(consensus == 2));
            if (num_1s >= num_2s)
                y = 1;
            else
                y = 2;
            end
        end
        
        function acc = test(obj,feats,class) 
            numPoint = size(feats,1);
            count = 0;
            for i = 1:numPoint
                x = feats(i,:);
                y = obj.classify(x);
                if (y == class)
                    count = count + 1;
                end
            end
            acc = count / numPoint;
        end
        
        function d = EclidDistance(obj,x1,x2)
            vec = x2(:) - x1(:);
            d = sqrt(dot(vec,vec));
        end
    end
end

