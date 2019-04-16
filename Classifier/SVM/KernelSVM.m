classdef KernelSVM
    %VANLLASVM 
    % vanilla flavor support vector machine
    
    properties
        w
        b
        C
        A
        T
        X
    end
    
    methods
        function obj = KernelSVM(C)
            %VANLLASVM 
            obj.C = C;
        end
        
        function obj = train(obj,feature,label)
            C = obj.C;
            N = size(label,1);
            % construct the quadratic programming problem to solve SVM
            % H the matrix inside the quadratic form
            H = zeros(N,N);
            for i = 1:N
                for j = i:N
                    % ti*tj*k(xi,xj)
                    ti = label(i);
                    tj = label(j);
                    xi = feature(i,:);
                    xj = feature(j,:);
                    H(i,j) = ti*tj*obj.k(xi,xj);
                    H(j,i) = H(i,j);
                end
            end
            % f linear term
            f = -ones(N,1);
            % Aeq equality linear system matrix
            Aeq = label';
            % beq equality constraint vector
            beq = 0;
            % lb
            lb = zeros(N,1);
            % ub
            ub = C*ones(N,1);
            % call quadratic programming
            Alg{1}='trust-region-reflective';
            Alg{2}='interior-point-convex';
            options=optimset('Algorithm',Alg{2},...
                'Display','on',...
                'MaxIter',10000);
            a = quadprog(H,f,[],[],Aeq,beq,lb,ub,[],options);
            obj.A = a;
            S = find(a>0==1);
            disp("number of support vectors")
            disp(length((S)));
            
            % calculate b by going through all support vectors
            M = find((a>0 & a <C)==1);
            b_ = 0;
            for i = 1:length(M)
                n = M(i);
                tn = label(n);
                xn = feature(n,:);
                sum_ = 0;
                for j = 1:length(S)
                    m = S(j);
                    am = a(m);
                    tm = label(m);
                    xm = feature(m,:);
                    sum_ = sum_ + am*tm*obj.k(xn,xm);
                end
                b_ = b_ + (tn - sum_);
            end
            b_ = b_ / length(M);
            
            obj.b = b_;
            obj.X = feature;
            obj.T = label;
        end
        
        function y = predict(obj,x)
            % y = obj.w'*obj.phi(x) + obj.b;
            y = obj.b;
            N = length(obj.A);
            for i = 1:N
                xn = obj.X(i,:);
                tn = obj.T(i);
                an = obj.A(i);
                y = y + an*tn*obj.k(x,xn);
            end
        end
        
        function acc = accuracy(obj,feature,label)
            N = size(label,1);
            count = 0;
            for i = 1:N
                x = feature(i,:);
                t = label(i);
                y = obj.predict(x);
                if(y>0)
                    t_hat = 1;
                else
                    t_hat = -1;
                end
                if(t==t_hat)
                    count = count + 1;
                end
            end
            acc = count/N;
            disp(acc);
        end
        
        function feat = phi(obj,x)
            %feat = x; % placeholder for feature transform
            feat = obj.poly2(x');
        end
        
        function val = k(obj,x1,x2)
            % no kernel
            %val = dot(obj.phi(x1),obj.phi(x2));
            % sigmoid kernel
            %val = obj.sigmoid(dot(obj.phi(x1),obj.phi(x2)));
            % polynomial kernel
            %val = dot(obj.polynomial(x1'),obj.polynomial(x2'));
            val = (dot(x1,x2) + 1)^1;
        end
        
        function p = polynomial(obj,x)
            n = length(x);
            first = [1;x];
            second = zeros(n*(n+1)/2,1);
            k = 1;
            for i = 1:n
                for j = i:n
                    val = x(i)*x(j);
                    second(k) = val;
                    k = k + 1;
                end
            end
            p = [first;second];
        end
        
        function p = poly2(obj,x)
            n = length(x);
            first = x;
            second = zeros(n,1);
            for i = 1:n
                second(i) = x(i)^2;
            end
            p = [first;second];
        end
        
        function val = sigmoid(obj,x)
            val = 1/(1+exp(-x));
        end
    end
end

