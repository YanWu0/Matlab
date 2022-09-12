
% This is an example function for finding the value and gradient for
% f(x,y)=5*x^2+6*y^2+7*z^2+8
% grad_vec=[10*x;12*y;14*z]
function [value,grad_vec]=val_gra(input_vec)

value = 5*input_vec(1)^2+6*input_vec(2)^2+7*input_vec(3)^2+8;
grad_vec = [10*input_vec(1); 12*input_vec(2); 14*input_vec(3)];

end