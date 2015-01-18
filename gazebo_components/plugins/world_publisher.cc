#include <gazebo/gazebo.hh>
#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/math/gzmath.hh>
#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <stdio.h>
#include <iostream>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/transport/transport.hh>
#include <iostream>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <sys/types.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> 

#define SOCKET_ERROR (-1)
#define INVALID_SOCKET (-1)
namespace gazebo
{
class World_Publisher : public WorldPlugin
{
  public: void Load(physics::WorldPtr _parent, sdf::ElementPtr /*_sdf*/)
  {
     this->number_of_agents = 50;
     this->max_collision_of_agents = 1;
     int number_of_rows = 5;
     int number_of_columns = number_of_agents / number_of_rows;
     int rand_amplitude = 2;          //must be times of 2
     int robot_type1 = 10;
     int robot_type2 = 20;
     int robot_type3 = 20;
     int total_number = robot_type1 + robot_type2 + robot_type3;
     int *robot_type_array = new int[number_of_agents] ;
     this->world = _parent;

    _parent->InsertModelFile("model://sun");
    _parent->InsertModelFile("model://ground_plane");

//INSERT MODELS
      transport::NodePtr node(new transport::Node());

      // Initialize the node with the world name
      node->Init(_parent->GetName());

      // Create a publisher on the ~/factory topic
      transport::PublisherPtr worldPub =
      node->Advertise<msgs::Factory>("~/factory");

      // Create the message
      msgs::Factory msg;

      
       
      double *init_positions[number_of_agents];
      int counter = 0;
      while(total_number > 0){
        int dummy_index = (int)(rand() % total_number);
        if(dummy_index >=0 && dummy_index < total_number){
          if(dummy_index >=0 && dummy_index< robot_type1){
            robot_type_array[counter] = 1;
            robot_type1 -= 1;
          }
          else if(dummy_index>=robot_type1 && dummy_index < (robot_type1 + robot_type2)){
            robot_type_array[counter] = 2;
            robot_type2 -= 1;
          }
          else {
            robot_type_array[counter] = 3;
            robot_type3 -= 1;
          }
        total_number = robot_type1 + robot_type2 + robot_type3;
        counter += 1;
        }
      }


      for (int i =0 ; i < number_of_rows; i++){
        for (int j =0 ; j < number_of_columns; j++){
          int dummy_index2 = (i*number_of_columns) + j;
           if(robot_type_array[dummy_index2] == 1){
             msg.set_sdf_filename("model://model1");}
           else if (robot_type_array[dummy_index2] == 2){
             msg.set_sdf_filename("model://model2");}
           else{
             msg.set_sdf_filename("model://model3");}
   
          init_positions[dummy_index2] = new double[2];
          init_positions[dummy_index2][1] = rand() % rand_amplitude + rand_amplitude/2 + 2 * i * this->max_collision_of_agents; 
          init_positions[dummy_index2][2] = rand() % rand_amplitude + rand_amplitude/2 + 2 * j * this->max_collision_of_agents; 
          msgs::Set(msg.mutable_pose(), math::Pose(math::Vector3((int)(init_positions[dummy_index2][1]) ,(int)(init_positions[dummy_index2][2]), 0), math::Quaternion(0, 0, 0)));
          worldPub->Publish(msg);
        }
      }
//INSERT MODELS

      // Listen to the update event. This event is broadcast every
      // simulation iteration.
      this->updateConnection = event::Events::ConnectWorldUpdateBegin(
          boost::bind(&World_Publisher::OnUpdate, this, _1));


     this->transporter= transport::NodePtr(new transport::Node());
     this->transporter->Init( this->world->GetName() );
     this->pub = this->transporter->Advertise<msgs::Pose>("~/world_publisher");
    
     this->sockfd = socket(AF_INET, SOCK_DGRAM, 0);
     if (sockfd < 0) 
        this->error("ERROR opening socket");

     server = gethostbyname("127.0.0.1");
     if (server == NULL) {
        fprintf(stderr,"ERROR, no such host\n");
        exit(0);
     }

     bzero((char *) &servaddr, sizeof(servaddr));
     servaddr.sin_family = AF_INET;
     bcopy((char *)server->h_addr, (char *)&servaddr.sin_addr.s_addr, server->h_length);
     servaddr.sin_port = htons(5051);
    
     if (connect(sockfd,(struct sockaddr *) &servaddr,sizeof(servaddr)) < 0) {}
     //   error("ERROR connecting");
  }

 // Called by the world update start event
    public: void OnUpdate(const common::UpdateInfo & /*_info*/)
    {
       int n = 0;
       memset(sendbuf,0,sizeof(sendbuf));
       this->model_list = this->world->GetModels();
    
      for( unsigned i = 1; i < model_list.size(); i++ ) {
         //this->model = model_list[i]->GetParentModel();
         //this->sdf_element = model->GetSDF();
         //std::string type = sdf_element->GetValueString("type");
         std::string model_name = model_list[i]->GetName();
         int id_and_type = 0;
         if(model_name.at(0) == '1')
           id_and_type = model_list[i]->GetId() * 10 + 1;
         else if (model_name.at(0) == '2')
           id_and_type = model_list[i]->GetId() * 10 + 2;
         else if (model_name.at(0) == '3')
           id_and_type = model_list[i]->GetId() * 10 + 3;

      
         math::Vector3 pos =model_list[i]->GetWorldPose().pos;
         math::Vector3 vel =model_list[i]->GetWorldLinearVel();  
         sprintf(sendbuf,"%s %f %f %f %f %f %d %d \n",sendbuf,pos.x, pos.y, pos.z, vel.x, vel.y, i, id_and_type);
         if(i == 25)  {
           n = write(sockfd,sendbuf,strlen(sendbuf));
           if (n < 0) {
             //error("ERROR writing to socket");
           }
           memset(sendbuf,0,sizeof(sendbuf));
         }
      }
      n = write(sockfd,sendbuf,strlen(sendbuf));
      if (n < 0) {
        //error("ERROR writing to socket");
      }
    }   

public: void error(const char *msg)
{
    perror(msg);
    exit(0);
}
   private: event::ConnectionPtr updateConnection;
   private: transport::NodePtr transporter;
   private: physics::WorldPtr world;
   private: physics::ModelPtr model;
   private: sdf::ElementPtr    sdf_element;
   private: physics::Model_V  model_list;
   private: transport::PublisherPtr pub;
   private: int sockfd ;
   private: struct sockaddr_in myaddr;
   private: struct sockaddr_in servaddr; /* server address */ 
   private: struct hostent *server;
   private: char sendbuf[16384];
   private: int number_of_agents;
   private: int max_collision_of_agents;
};

// Register this plugin with the simulator
GZ_REGISTER_WORLD_PLUGIN(World_Publisher)
}




