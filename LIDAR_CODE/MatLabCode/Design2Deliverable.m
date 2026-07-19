% 2DX3 Studio 9 - Exercise 2 - MATLAB Serial Communication
%
% Description:
%   Establishes UART communication between PC (MATLAB) and MCU.
%   PC sends the start character 's' to the MCU to trigger transmission.
%   MCU then sends 10 rounds of measurement data as formatted strings,
%   each terminated with \r\n (carriage return + newline).
%   MATLAB reads and prints each full line to the Command Window.
%
%   MCU sends lines in the format:
%   "measurement #(i), data1 (x), data2 (x), data3 (x)\r\n"
%
% MCU Baud Rate: 115200 bps (PIOSC 16MHz, IBRD=8, FBRD=44)
%
% Usage:
%   1. Flash the 2DX_2022_Studio_E2 Keil project onto your MCU.
%   2. Update the 'port' variable below to match your COM port.
%      - Windows: "COM3", "COM4", etc.
%      - Mac:     "/dev/cu.usbmodemXXXXXX"
%      Run >> serialportlist    in MATLAB Command Window to find your port.
%   3. Run this script.

%% Configuration 
port     = "COM4";       % <-- CHANGE THIS to your MCU's serial port
baudrate = 115200;       % Must match MCU UART_Init() setting

%% Open the serial port 
device = serialport(port, baudrate);
device.Timeout = 10;     % 10 second read timeout

% Configure line terminator to match MCU's \r\n output
% readline() will read until it sees a newline (LF = "\n")
configureTerminator(device, "CR/LF");

fprintf("Opening: %s\n", port);

%% Flush / reset the buffers
flush(device);

%% Wait for user to press Enter 
input("Press Enter to start communication...");

%% Send start flag 's' to MCU via UART
write(device, 's', "char");
m = []; 
y = []; 
z = []; 

x_positions=[];
L = readline(device); 
scan = split(L, ",");


counters = str2double(scan{1}); 
angle = []; 
C = []; 
for o = 1: counters 
    for l = 1:32
        C(l+(o-1)*32) = o; 
    end 
end 

%% Receive 10 lines of measurement data from MCU 
fprintf("\nReceived measurements:\n");
for j = 1:counters
   for i = 1:32
        X = readline(device);   % Read one full line
        fprintf("%s\n", X);
        parts = split(X,",");
  
        m(i+(j-1)*32) = str2double(parts{1});
    
  end
end


for h = 1:32
    angle(h) = 90 + 11.25*(h-1);
end
%% Close the serial port 
fprintf("Closing: %s\n", port);
clear device;

% double(parts{2})
% value = str2double(parts{2});
for h = 1:counters
    x_positions(h) = 100*z;
    
end
%%Conversion 
for i = 1:32*counters
    d = m(i); 
 
    theta = deg2rad(angle(mod(i-1,32)+1)); 

    y(i) = d*sin(theta); 
    z(i) = d*cos(theta);

   
end 
x = repelem(x_positions, 32);
%%Graphing
subplot(1,2,1); 
scatter3(x,y,z,60,C,'filled') 
colormap(gca, jet(counters))
cb = colorbar; cb.Ticks = 1:counters; 
cb.TickLabels = arrayfun(@(x) sprintf('x =%.1f',x), x_positions, 'UniformOutput',false);
% cb.TickLabels = {'x=10'};
xlabel('X -displacement(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')
title ('Scatter plot')
hold on; 
for p= 1:counters 
    idx = (C==p);

    ind = find(idx);
   

    x_loop = [x(ind),x(ind(1))];
    y_loop = [y(ind), y(ind(1))];
    z_loop = [z(ind), z(ind(1))];
    cmap = jet(counters); 
    
    plot3(x_loop,y_loop,z_loop,'-k','Color',cmap(p,:),'LineWidth',2,'MarkerSize',5, 'MarkerFaceColor',cmap(p,:));

end
axis equal
grid on 
