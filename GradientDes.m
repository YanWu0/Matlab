function [iter_num, value_vec, grad_vec]=GradientDes(init_guess, learn_rate, max_iter, min_grad)

value_vec = [];
grad_vec = [];

iter_num = 0;
cur_x = init_guess;
[cur_val, cur_grad] = val_gra(cur_x);
value_vec = [value_vec; transpose(cur_val)];
grad_vec = [grad_vec; transpose(cur_grad)];

    while (iter_num < max_iter) & ((cur_grad(1) > min_grad(1)) | (cur_grad(2) > min_grad(2)) | (cur_grad(3) > min_grad(3))) 

        iter_num = iter_num + 1;
        cur_x = cur_x - learn_rate * cur_grad;
        [cur_val, cur_grad]= val_gra(cur_x);
        value_vec = [value_vec; transpose(cur_val)];
        grad_vec = [grad_vec; transpose(cur_grad)];

    end
end