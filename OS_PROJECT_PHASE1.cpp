#include<iostream>
#include<fstream>
using namespace std;


class OS
{

private:
  char M[200][4]; 
        char IR[4];       
        char R[4];         
        int IC;             
        int SI;             
        bool toggle;   
        char buffer[40]; 


public:
        void init();
        void LOAD();
        void Execute();
        void MOS();


        fstream infile;
        fstream outfile;
};





void OS::init()

{
    for(int i=0; i<200; i++)
    {    
        for(int j=0; j<4; j++)
            M[i][j]=' ';
        
    }   

    IR[0]={' '};
    R[0]={' '};
    toggle=false;

}


void OS::MOS()
{

 // service interrupt conditions  
    if(SI==1)     
    {  
        for(int i=0;i<=39;i++)buffer[i]='\0';
            
        infile.getline(buffer,40);
       
        int coun=0,  i=IR[2]-48;

        i=i*10;
        
        
        for(int l=0 ; l<10 ; ++l)
        {   
            for(int j=0 ; j<4; ++j)
            {
                M[i][j]=buffer[coun];
                coun++;                
            }

            if(coun==40) break;

            i++;
        }
    }
        
    else if(SI==2)    
    {


      for(int i=0;i<=39;i++)
           buffer[i]='\0';
        
        int coun=0;


        int i=IR[2]-48;


        i=i*10;
        
        
        for(int l=0;l<10 ;++l)
        {   
            for(int j=0;j<4;++j)
            {
                buffer[coun]=M[i][j];
                outfile<<buffer[coun];

                coun++;                
            }



            if(coun==40) break;                
            
            i++;
        }
 
    
        outfile<<"\n";
      
    }


}




void OS::Execute()

{  
    while(true)
    {

        for(int i=0; i<4; i++)       
            IR[i]=M[IC][i];

        IC++;


      //to compare with GD 
        if(IR[0]=='G'&&IR[1]=='D') 
        {
            SI=1;
            MOS();
        }


        //to compare with PD
        else if(IR[0]=='P'&&IR[1]=='D')       
        {
            SI=2;
            MOS();
        }


         // to halt program
        else if(IR[0]=='H')
        {
            SI=3;
            MOS();
            break;
        }


       //to compare with load register
        else if(IR[0]=='L'&&IR[1]=='R')     
        {
            int i=IR[2]-48;
            i=i*10+(IR[3]-48);

            for(int j=0;j<=3;j++)  
                R[j]=M[i][j];

            
            cout<<endl; 
        }



       //to compare with Store register
        else if(IR[0]=='S'&&IR[1]=='R') 
        {
            int i=IR[2]-48;
            i=i*10+(IR[3]-48) ;
   
            for(int j=0;j<=3;j++)  
                M[i][j]=R[j];
            
            cout<<endl; 
        }



       //to compare register check if VIT is matching with VIIT
        else if(IR[0]=='C'&&IR[1]=='R')  
        {
            int i=IR[2]-48;
            i=i*10+(IR[3]-48);
          
            int count=0;
           
            for(int j=0;j<=3;j++)
                if(M[i][j]==R[j])
                    count++;
                    
            if(count==4)
                toggle=true;

        }

        
    }
}





void OS::LOAD()
{
    

 
    int temp=0;
    do
    {   
        for(int i=0;i<=39;i++)     
           buffer[i]='\0';

        infile.getline(buffer,40);

        for(int k=0;k<=39;k++)      
           cout<<buffer[k];
        
        if(buffer[0]=='$'&&buffer[1]=='A'&&buffer[2]=='M'&&buffer[3]=='J')init();
  
        else if(buffer[0]=='$'&&buffer[1]=='D'&& buffer[2]=='T'&&buffer[3]=='A')
        {
            IC=00;
            Execute();
        
        }
        else if(buffer[0]=='$'&&buffer[1]=='E'&&buffer[2]=='N'&&buffer[3]=='D')
        {  
            temp=0;
            continue;
        }
        else
        {
            int coun=0;
            
            for(;temp<100; ++temp)
            {   
                for(int j=0 ; j<4; ++j)
                {
                    
                    M[temp][j]=buffer[coun];
                    coun++;
                }
                
                if(coun==40||buffer[coun] == ' '||buffer[coun]=='\n')break;
                
            }   
             
        }

    }while(!infile.eof()); 
        
    
}




int main()
{ 
    OS os;

    os.infile.open("input.txt", ios::in);
    os.outfile.open("output.txt", ios::out);
      
    os.LOAD();

    return 0;
}