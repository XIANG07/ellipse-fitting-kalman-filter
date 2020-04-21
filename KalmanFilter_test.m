%% singal phase calculate by KF
% Note:
% We draw the Lissajous figure of the same frequency signals.
% Then, fit the ellipse eqution and we can know the phase-difference
% through the eqution.
% ͬƵ�ź���λ���㣬�Ƚ��źŲ������ٽ��źŻ��Ƴ�������ͼ
% ���ͼ�η��̣����ݷ�������λ�
%
% Author:Li haojia
% DATE   2020.4.21


%generate and simple singal  �����ź�
f=10; w=2*pi*f; %Frequency 
phase = pi/2;
s_t=[0:0.001:0.2];
SIGMA=0.01;
noisy=normrnd(0,SIGMA,[1,length(s_t)]);
s_x=sin(w*s_t);
s_y=sin(w*s_t+phase)+noisy;

state=[0,0,0,0,0]'; %initial ellipse coefficients ��ʼ��ϵ��
p_state=[
    1,0,0,0,0;
    0,1,0,0,0;
    0,0,1,0,0;
    0,0,0,1,0;
    0,0,0,0,1;];%initial covariance ��ʼ��Э����ϵ��һ�㲻�ø�

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
    %KF �������˲�
    [state,p_state]=KFcore(state,p_state,[x(i),y(i)]);
    A=state(1);B=state(2);C=1-state(1);D=state(3);E=state(4);F=state(5);  %ellipse coefficients ��Բϵ��
    
    %Draw figure 
    [Xc,Yc,a,b,angle] = Matrix2AngleForm(state(1),state(2),1-state(1),state(3),state(4),state(5));
    plotEllipse(Xc, Yc, a, b, rad2deg(angle), 360,'Color','green','LineWidth',1);
    hold on
    plot(x,y,'.','MarkerSize',5,'Color','red');
    hold off
    drawnow;
end


%

