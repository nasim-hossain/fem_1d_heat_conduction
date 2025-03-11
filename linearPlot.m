clc
clear all

D1=readmatrix('resultData.xlsx');
%exact results
ex=D1(1:20,1)
ey=D1(1:20,2)

%2 element linear
fx2=D1(1:3,4)
fy2=D1(1:3,5)
%3 element linear
fx3=D1(6:9,4)
fy3=D1(6:9,5)
%4 element linear
fx4=D1(12:16,4)
fy4=D1(12:16,5)
%5 element linear
fx5=D1(19:24,4)
fy5=D1(19:24,5)

% 1 quadratic element
fqx1=D1(1:3,7)
fqy1=D1(1:3,8)

%2 quadratic element
fqx2=D1(6:10,7)
fqy2=D1(6:10,8)

%3 quadratic element
fqx3=D1(13:19,7)
fqy3=D1(13:19,8)


figure(1)
plot(ex,ey,'k*',fx2,fy2,'r--',fx5,fy5,'b-.','linewidth',2);
legend('Exact solution','2 linear element','5 linear element','Location','northwest'); legend('boxoff');
set(gca,'Fontname','Arial','Fontsize',16,'Fontweight','bold');
%title('Comparison among exact and different number of linear element')
xlim([0 20]); ylim([0 4500]);
xlabel('Length(m)');
ylabel('Temperature(C)');

figure(2)
plot(ex,ey,'k*',fqx1,fqy1,'r--',fqx3,fqy3,'b-.','linewidth',2);
legend('Exact solution','1 quadratic element','3 quadratic element','Location','northwest'); legend('boxoff');
set(gca,'Fontname','Arial','Fontsize',16,'Fontweight','bold');
%title('Comparison among exact and different number of linear element')
xlim([0 20]); ylim([0 4500]);
xlabel('Length(m)');
ylabel('Temperature(C)');