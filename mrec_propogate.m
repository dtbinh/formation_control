  n     = evalin('base', 'n');
  X     = evalin('base', 'X');
  Y     = evalin('base', 'Y');
  s1    = evalin('base', 'mrec_s1');
  s2    = evalin('base', 'mrec_s2');
  mean  = evalin('base', 'mrec_mean');
  theta = evalin('base', 'mrec_theta');
  mrec_active = evalin('base', 'mrec_active');
  pos_array = [X' ; Y'];
  k_mean  = 0.1;
  k_theta = 0.02;
  k_scale = 0.1;
  
  
  s = s1 + s2; 
  %desired values
  mean_desired  = mean;
  %mean_desired  = [10 -25]';
  s_desired     = s;
  %s_desired     = 40;
  theta_desired = theta;
  %theta_desired = -1.5;
  %desired values

  
  if((mean_desired ~= mean) | (s_desired~=s) | (theta_desired~=theta))
    if(mrec_active == 0)
      mrec_mean_dif  = mean_desired - mean;
      mrec_s_dif     = s_desired - s;
      mrec_theta_dif = theta_desired - theta;
    
      assignin('base', 'mrec_mean_dif', mrec_mean_dif);
      assignin('base', 'mrec_theta_dif', mrec_theta_dif);
      assignin('base', 'mrec_s_dif', mrec_s_dif);
      reorientate_shape
      formation_sendto_gazebo = 1;
      assignin('base', 'formation_sendto_gazebo', formation_sendto_gazebo);
    end
    mrec_active = 1; % new mrec request available
  else
    mrec_active = 0; % no mrec request, go on with formation control
  end
  
  
  if(mrec_active == 1)
     
    mean_dot  = k_mean  * (mean_desired - mean);
    theta_dot = k_theta * (theta_desired - theta);
    s_dot     = k_scale * (s_desired - s);  
    
  
    %compute rotational velocities
    for i = 1 : 1 : n
      angle = atan2 ((Y(i) - mean(2)),(X(i) - mean(1)));
      angle = angle + theta_dot;
    
      distance = sqrt((X(i) - mean(1))^2 + (Y(i) - mean(2))^2);
     
      [x_comp y_comp] = pol2cart(angle,distance);
      x_rotation = mean(1) + x_comp;
      y_rotation = mean(2) + y_comp;
      rotational_velocity = [(x_rotation - X(i)) (y_rotation - Y(i))]';
      velocity(:,i)  =  mean_dot  + rotational_velocity + (((pos_array(:,i) - mean) * s_dot) / (2 * s));
      force_matrix(1,7,i) = velocity(1,i)*900;
      force_matrix(2,7,i) = velocity(2,i)*900;
    end
    %compute rotational velocities  
    assignin('base', 'mrec_theta_dot', theta_dot);
    assignin('base', 'mrec_mean_dot', mean_dot);
    assignin('base', 'mrec_s_dot', s_dot);
    assignin('base', 'Xdot', velocity(1,:));
    assignin('base', 'Ydot', velocity(2,:));
    assignin('base', 'Xdot_real', velocity(1,:)');
    assignin('base', 'Ydot_real', velocity(2,:)');    
  end

  
  assignin('base', 'force_matrix', force_matrix);
  assignin('base', 'mrec_active', mrec_active);


  
  
  