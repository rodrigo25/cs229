function [ X, y ] = loadData()

  load logistic_x.txt
  load logistic_y.txt
  
  X = logistic_x;
  y = logistic_y;

end

