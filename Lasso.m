
% initialize attribute matrix A(50*100) and true coefficient vector x 
A = normrnd(0,1,[50,100]);
nonzero_pos = transpose(flip(randsample(100,5)));
nonzero_val = normrnd(0,1,[1,5]);
x_true = zeros(100,1);
x_true(nonzero_pos) = nonzero_val;
% calculate b, by Ax=b
b = A*x_true;

%------------------------------------------------------------------
% least squared solution
x_leastsquared = lsqr(A,b);

%------------------------------------------------------------------
% Lasso solution

n = size(A,2);
old_x = normrnd(0,1,[n,1]);
new_x = old_x+ones(n,1);
lambda = 0.1;
epsi = 0.001;
iter = 0;

p_vec = [];
for i = 1:n
    p = transpose(A(:,i))*A(:,i);
    p_vec = [p_vec, p];
end


while norm(new_x-old_x) > epsi
    
    iter = iter + 1
    
    old_x = new_x;
    temp_x = old_x;
    
    for i = 1 : n
       
        t = b - (A*temp_x - A(:,i)*temp_x(i));
        q = transpose(A(:,i))*t;
        
        if q > lambda
            temp_x(i) = (q-lambda)/p_vec(i);
        elseif q + lambda < 0
            temp_x(i) = (q+lambda)/p_vec(i);
        else
            temp_x(i) = 0;
        end
    
    new_x = temp_x;
    end
end
fprintf('iteration = %i\n', iter)
fprintf('norm of true-opt = %f\n', norm(x_true - new_x))



%--------------------------------------------------------------------
% lambda selection

lambda_vec = logspace(-10,10,20);
iter_vec = [];
norm_vec = [];
for j = 1 : 20
    
    lambda = lambda_vec(j);
    iter = 0;
    
    old_x = ones(100,1);
    new_x = old_x * (1/2) ;
    

    while norm(new_x-old_x) > epsi
    
        iter = iter + 1
    
        old_x = new_x;
        temp_x = old_x;
    
        for i = 1 : n
          
            t = b - (A*temp_x - A(:,i)*temp_x(i));
            q = transpose(A(:,i))*t;
        
            if q > lambda
                temp_x(i) = (q-lambda)/p_vec(i);
            elseif q + lambda < 0
                temp_x(i) = (q+lambda)/p_vec(i);
            else
                temp_x(i) = 0;
            end
    
        new_x = temp_x;
        end
    end
  
    iter_vec = [iter_vec, iter];
    norm_vec = [norm_vec, norm(x_true-new_x)];
    
end

figure;

yyaxis left
semilogx(lambda_vec, iter_vec, 'r')

hold on

yyaxis right
semilogx(lambda_vec, norm_vec, 'b')

legend({'iter num', 'norm of true-opt'}, 'FontSize',14)
xlabel('lambda')

grid on


