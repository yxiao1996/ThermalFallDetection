classdef OneVOnePredict
    %ONEVRESTPREDICT 
    % one versus one approach to ensemble two-class SVM to 
    % multiple classes
    
    properties
        classifiers
        N % total number of classes
    end
    
    methods
        function obj = OneVOnePredict(classifiers,n)
            %ONEVRESTPREDICT 
            obj.classifiers = classifiers;
            obj.N = n;
        end
        
        function t = predict(obj,x)
            vote = zeros(obj.N,1);
            for i = 1:size(obj.classifiers,1)-1
                for j = i+1:size(obj.classifiers,1)
                    svm = obj.classifiers{i,j};
                    y = svm.predict(x);
                    if(y>0)
                        vote(i) = vote(i) + 1;
                    else
                        vote(j) = vote(j) + 1;
                    end
                end
            end
            % find the max vote
            max_val = max(vote);
            max_idx = find(vote==max_val);
            t = max_idx(1) - 1;
        end
        
        function acc = accuracy(obj,feature,label)
            n = size(label,1);
            count = 0;
            for i = 1:n
                x = feature(i,:);
                t = label(i);
                t_hat = obj.predict(x);
                if(t==t_hat)
                    count = count + 1;
                end
            end
            acc = count/n;
        end
        
        function cm = ConfusionMatrix(obj,feature,label)
            n = size(label,1);
            cm = zeros(obj.N,obj.N);
            count = zeros(obj.N,1);
            for i = 1:n
                x = feature(i,:);
                t = label(i);
                t_hat = obj.predict(x);
                cm(t+1,t_hat+1) = cm(t+1,t_hat+1) + 1;
                count(t+1) = count(t+1) + 1; 
            end
            for i = 1:obj.N
                c = count(i);
                cm(i,:) = cm(i,:) / c;
            end
        end
    end
end

