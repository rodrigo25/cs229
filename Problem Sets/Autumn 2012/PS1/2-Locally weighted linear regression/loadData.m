function [ X, y ] = loadData()

  load q2x.dat
  load q2y.dat
  
  X = q2x;
  y = q2y;

end

