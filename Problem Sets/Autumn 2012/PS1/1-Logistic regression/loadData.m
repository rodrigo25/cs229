function [ X, y ] = loadData()

  load q1x.dat
  load q1y.dat
  
  X = q1x;
  y = q1y;

end

