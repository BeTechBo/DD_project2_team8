# DD_project2_team8
# By Omar Saqr - Adham Ali - Ebram Thabet

The project is an alarm/clock implemented on the fpga (Basys 3). It has the following features:
1- The clock is a minute-hour clock with the ability to adjust the displayed clock by pressing BTNC on the FPGA. 
2- An alaram can be adjusted as well by pressing BTNC and moving between the modes using BTNL and BTNR. If 
LD 14 and LD 15 are on, this means the alarm is being adjusted.
3- When the adjusted alarm matches the current clock, a buzzer rings.

# How to run the code:

1- Download vivado and run on it the project in the folder "DigitalDesign_Project 2/DigitalDesign_Project 2". 
2- Make sure to download the Basys 3 board online and choose it from the boards on vivado when creating a new project.
3- Make sure that the module "CLOCK.v" is set as top in the hierarchy. 
4- Connect the FPGA to the computer. 
5- Click on run implementation then generate bitstream. 
6- Then run the program on the FPGA using "open hardware manager" and click on "program."

# Should you have any inquiries, please reach to us. 
# Emails: ebram_raafat@aucegypt.edu, omar_saqr@aucegypt.edu, adhamahmed804@aucegypt.edu
