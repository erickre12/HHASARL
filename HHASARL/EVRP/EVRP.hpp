#define CHAR_LEN 100
#define TERMINATION 25000*ACTUAL_PROBLEM_SIZE      //DO NOT CHANGE THE NUMBER


extern char* problem_instance;          //Name of the instance
void init_evals();                        //initializes the evaluations
void init_current_best();                //initializes the best solution quality

struct node {
  int id;
  double x;
  double y;
};


//PARAMETERS THAT CAN BE USED IN YOUR ALGORITHM IMPLEMENTATION
extern int NUM_OF_CUSTOMERS;            //number of customer set
extern int ACTUAL_PROBLEM_SIZE;         //total number of nodes
extern int NUM_OF_STATIONS;    //number of charging stations
extern int MAX_CAPACITY;                //maxmimum cargo capacity
extern int DEPOT;                        //id of the depot
extern double OPTIMUM;     //Global optimum (or upper bound) of the problem instance (if known)
extern int BATTERY_CAPACITY;            //maximum energy level
extern int MIN_VEHICLES;

//METHODS THAT CAN BE USED IN YOUR ALGORITHM IMPLEMENTATION
double fitness_evaluation(int *routes, int size);        //evaluates an EVRP solution
void print_solution(int *routes, int size);                 //used to print the solution
void check_solution(int *routes, int size);                 //used to validate the solution
void read_problem(char* filename);                    //reads .evrp file
double get_energy_consumption(int from, int to);    //returns the energy consumption
int get_customer_demand(int customer);                //returns the customer demand
double get_distance(int from, int to);                //returns the distance
bool is_charging_station(int node);                    //returns true if node is a charging station
double get_current_best();                            //returns the best solution quality from all evaluation
double get_evals();                                    //returns the number of evaluations
void free_EVRP();                                    //free memory





