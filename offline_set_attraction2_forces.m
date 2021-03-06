  offline_inside_outside_array  = evalin('base', 'offline_inside_outside_array');
  
  X  = evalin('base', 'X_offline');
  Y  = evalin('base', 'Y_offline');
  
  formation_x = evalin('base', 'formation_x');
  formation_y = evalin('base', 'formation_y');
  
  array_length = length(formation_x);
  
  offline_force_matrix = evalin('base', 'offline_force_matrix');
  
  offline_ka2  = evalin('base', 'offline_ka2');
 
  n = evalin('base', 'n');
  
  offline_force_matrix(:,5,:) = 0 ; % attractive force2 sutununu sifirlayalim
  for i = 1 : 1 : n
    if(offline_inside_outside_array(i) ~= 1) %eger agent shape icerisinde degilse hesaplansin
      for j = 1 : 1 : array_length
        distance_to_point = norm([(formation_x(j) - X(i))  (formation_y(j) - Y(i))]);
        offline_force_matrix(1,5,i) = offline_force_matrix(1,5,i) + ((formation_x(j) - X(i)) / (distance_to_point)^3);
        offline_force_matrix(2,5,i) = offline_force_matrix(2,5,i) + ((formation_y(j) - Y(i)) / (distance_to_point)^3);
      end
        offline_force_matrix(1,5,i) = (offline_force_matrix(1,5,i) * offline_ka2) / array_length;
        offline_force_matrix(2,5,i) = (offline_force_matrix(2,5,i) * offline_ka2) / array_length;
    end
  end
  
 assignin('base', 'offline_force_matrix', offline_force_matrix);




