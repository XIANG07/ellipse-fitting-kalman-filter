%% singal phase calculate by least square
% Note:
% We draw the Lissajous figure of the same frequency signals.
% Then, fit the ellipse eqution and we can know the phase-difference
% through the eqution.
% ͬƵ�ź���С���˷��ź���λ���㣬�Ƚ��źŲ������ٽ��źŻ��Ƴ�������ͼ
% ���ͼ�η��̣����ݷ�������λ�
%
% Author:Li haojia
% DATE   2020.4.21


%generate and simple singal  �����ź�
f=10; w=2*pi*f; %Frequency 
phase = pi/2;
s_t=(0:0.001:0.2);
SIGMA=0.01;
noisy=normrnd(0,SIGMA,[1,length(s_t)]);
s_x=sin(w*s_t);
s_y=sin(w*s_t+phase)+noisy;



for i=1:length(s_t)
    %sample ģ���źŲ���
    t=s_t(1:i);
    x=s_x(1:i);
    y=s_y(1:i);
    %draw figure ��ͼ
    subplot(3,2,1);
    plot(t,x);
    subplot(3,2,3);
    plot(t,y);
    subplot(3,2,5)
    plot(t,noisy(1:i))
    subplot(1,2,2);

  %least square method ��С���˷�
    state2=lssquare(x,y);
    A=state2(1);B=state2(2);C=1-state2(1);D=state2(3);E=state2(4);F=state2(5);  %ellipse coefficients ��Բϵ��
    %equ:p(1)*x^2+p(2)*(x*y)+(1-p(1))*y^2+p(3)*x+p(4)*y+p(5)=0
    
    
    %Draw figure 
    [Xc,Yc,a,b,angle] = Matrix2AngleForm(state2(1),state2(2),1-state2(1),state2(3),state2(4),state2(5));
    plotEllipse(Xc, Yc, a, b, rad2deg(angle), 360,'Color','green','LineWidth',1);
    
    hold on
    plot(x,y,'.','MarkerSize',5,'Color','red');
    hold off
    %pause(0.01);
    drawnow;
end


%

