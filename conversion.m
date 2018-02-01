% -------------------------------------------------------------
% This is a growing tutorial demonstrates some MATLAB examples and their  
% equivalent code in Python
%
% Each Matlab block function corresponds a block in conversion.ipynb
%
% written by Richard Xu (yida.xu@uts.edu.au)
%
% Jan 2018
%
% -------------------------------------------------------------

function conversion

    clear all;
    clc;

    %block_numpy_multiply
    %block_matrix_find
    %block_numpy_reshape
    %block_numpy_unique
    %block_direction_plot   
    %block_inline_function
    %block_map_reduce
    block_read_csv
end


% this is to create another table to compute the total sales
function block_read_csv
    
   store = readtable('superstore.xls');
   
   [val, indices, inv_indices] =  unique(store.CustomerID);
    
   profit = zeros(length(val),1);
   for v = 1:length(val)
       cus_list = find(store.Profit(inv_indices == v));
       profit(v)= sum(store.Profit(cus_list));
   end
   
   profitT = table(val,profit);
   
   profitT.Properties.VariableNames = {'CustomerID','total_profit'};
   
end



% this is a peudo map reduce

function block_map_reduce
    
    items = -2:3-0.001
    sigmoid_func2 = @(x) 1 /(1 + exp(-x));

    
    sigmoids = [];
    for i = 1:length(items)
        sigmoids = [sigmoids sigmoid_func2(items(i))];
    end
    
    display(sigmoids)

    sigmoids = arrayfun(@(x) 1/(1 + exp(-x)), items)
    
    prods = prod(sigmoids);
    prod3 = prod(sigmoids(sigmoids>0.2));
    
    display(prods);
    display(prod3);

end


function block_inline_function

    function val = sigmoid_func(x)
        val = 1 /(1 + exp(-x));
    end
    
    display(sigmoid_func(2))
    
    sigmoid_func2 = @(x) 1 /(1 + exp(-x));

    display(sigmoid_func2(2))

end



function block_numpy_multiply

    A = [3 4; 2 5];
    B = [5 6; 3, 2];

    % ----------------------------

    C = A * B;
    C2 = A* B * C;
    display (C);
    display (C2);

    % ----------------------------

    W1 = A .* B;
    W2 = A .* B .* C;

    display(W1)
    display(W2);

end


% --------------------------------------

function block_matrix_find
    
    a_list = magic(3);
    a_list = [ 8, 1, 6; 3, 5, 7; 4, 9, 2]
    
    display(a_list > 5)
    display(a_list( a_list > 5 ))

end


function block_numpy_reshape

    a_list = [16, 2, 3, 13; 5, 11, 10, 8; 9, 7, 6, 12 ;4, 14, 15, 1];

    b_list = reshape(a_list,[2,8]);
    display(b_list);
    
    b_list = reshape(a_list,[8,2]);
    display(b_list);
    
    b_list = reshape(a_list',[8,2]);
	display(b_list);
    
    b_list = reshape(a_list',1,[]);
	display(b_list);
    
    display(a_list(1,4))


end



function block_numpy_unique
    a_list = floor(rand(5,5) * 5) + 5
    display(a_list)
    [val, indices, inv_indices] =  unique(a_list);
    
    % MATLAB can access elements directly without changing to 1-D  
    for v = 1:length(val)
        display( a_list(find( a_list == val(v) )))
    end

end





function block_direction_plot

    %A = [1.2 2.4; 3.1 7.0];
    A = [3.1 7.0; 1.2 2.4];
    B = [1.0 1.8; 2.5 5.2];
    
    line(A(:,1),A(:,2),'color',[0 1 0]);
    hold on;
    plot(A(1,1),A(1,2),'o','MarkerFaceColor',[0.9 0.9 0.9]);
    plot(A(2,1),A(2,2),'o','MarkerFaceColor',[0 0 0]);
    
    line(B(:,1),B(:,2),'color',[0 1 1]);
    
    plot(B(1,1),B(1,2),'o','MarkerFaceColor',[0.9 0.9 0.9]);
    plot(B(2,1),B(2,2),'o','MarkerFaceColor',[0 0 0]);
    
    A_dir = A(2,:) - A(1,:);
    A_dir = A_dir /norm(A_dir);
    
    B_dir = B(2,:) - B(1,:);
    B_dir = B_dir /norm(B_dir);
    
    theta = acos(A_dir * B_dir')
    
    text_min = min([A;B]);
    
    if abs(theta)< 0.2
              text(text_min(1)+1,text_min(2),['theta = ' num2str(theta,'%.2f') ': same direction']); 
    end
    
    if abs(theta) > pi - 0.2
       text(text_min(1)+1,text_min(2),['theta = ' num2str(theta,'%.2f') ': opposite direction']); 
    end
    
end
