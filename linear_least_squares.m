%function [x y] = linear_least_squares(b1,b2,b3,r1,r2,r3)
function [x y] = linear_least_squares(agent_index,beacon_array)
X_real = evalin('base', 'X_real');
Y_real = evalin('base', 'Y_real');
X = evalin('base', 'X');
Y = evalin('base', 'Y');



%b1 = [1 5]; %komsu 1
%b2 = [3 7]; %komsu 2
%b3 = [5 6]; %komsu 3
%t  = [3 6]; %gercek nokta

%x1 = b1(1);
%y1 = b1(2);
%x2 = b2(1);
%y2 = b2(2);
%x3 = b3(1);
%y3 = b3(2);

%error = rand(3,1) / 2  - 0.25 ; %error between +/- 0.25

%r1 = norm([(t(1)-b1(1)) (t(2)-b1(2))]) + error(1);
%r2 = norm([(t(1)-b2(1)) (t(2)-b2(2))]) + error(2);
%r3 = norm([(t(1)-b3(1)) (t(2)-b3(2))]) + error(3);
r1 = norm([(X_real(agent_index) - X_real(beacon_array(1))) (Y_real(agent_index) - Y_real(beacon_array(1)))]);
for i = 2 : 1 : length(beacon_array)
  A((i-1),1) = X(beacon_array(i)) - X(beacon_array(1));  % A matrisinin elemanlari X-Y degerleri ile hesaplandi, gercek degerler ile degil
  A((i-1),2) = Y(beacon_array(i)) - Y(beacon_array(1));
  r      = norm([(X_real(agent_index) - X_real(beacon_array(i))) (Y_real(agent_index) - Y_real(beacon_array(i)))]);
  d      = norm([(X_real(beacon_array(1)) - X_real(beacon_array(i))) (Y_real(beacon_array(1)) - Y_real(beacon_array(i)))]);
  B(i-1)   = (r1^2 - r^2 + d^2) / 2;
end

if(rank(A) == 2) % A is full column rank matrix, direct solution or minimum norm solution is available
  if(length(beacon_array) == 3) % A is full column 2*2 matrix, direct solution available
    pos = pinv(A) * B';
    pos(1) = pos(1) + X_real(beacon_array(1));
    pos(2) = pos(2) + Y_real(beacon_array(1));
    x = pos(1);
    y = pos(2);
  else % A is full column and a unique minimum norm solution is available
    pos = pinv((A') * A) * A' * B'; 
    pos(1) = pos(1) + X_real(beacon_array(1));
    pos(2) = pos(2) + Y_real(beacon_array(1));
    x = pos(1);
    y = pos(2);
  end
elseif(rank(A) == 1) % columns of A is linear dependent and minimum norm solution will be derived with non linear least squares
    pos = pinv((A') * A) * A' * B';
    pos(1) = pos(1) + X_real(beacon_array(1));
    pos(2) = pos(2) + Y_real(beacon_array(1));
    x = pos(1);
    y = pos(2);
    theta = [x y]';
    %[x y] = nonlinear_least_squares(agent_index, theta, beacon_array);    
end

%{
d21 = norm([(b2(1)-b1(1)) (b2(2)-b1(2))]);
d31 = norm([(b3(1)-b1(1)) (b3(2)-b1(2))]);

b21 = (r1^2 - r2^2 + d21^2) / 2;
b31 = (r1^2 - r3^2 + d31^2) / 2;

A = [(b2(1)-b1(1)) (b2(2)-b1(2)); (b3(1)-b1(1)) (b3(2)-b1(2))];
B = [b21;b31];

pos = pinv(A' * A) * A'*B;
pos = pos + b1';
x = pos(1);
y = pos(2);

%}

end


