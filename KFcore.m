function [new_state,new_p] = KFcore(last_state,last_p,new_observation)
%KFcore use Kalman filter to sovle ellipse coefficient
% useage: 
% input: last_state ��һ�μ����ϵ��
% input: last_p ��һ�ε�Э�������
% input: new_observation �µĲ���ֵ������������ͼ�����ĵ�
% output: new_state �µ�ϵ��
% output: new_p �µ�Э�������
% note: ��Բ����:state(1)*x^2+state(2)*(x*y)+(1-state(1))*y^2+state(3)*x+state(4)*y+state(5)=0 
% ����һ����׼�Ŀ������˲����������е�˵���������������չ�������˲������ǵ�ȷ���������Ի���

sigma_o=1e-4;      %observation model convariance  ����ģ��Э����
sigma_w=1e-10*eye(5);  %prediction model convariance   Ԥ��ģ��Э����  ����0Ҳ�� 

state=last_state;  

p= last_p+sigma_w;
x=new_observation(1);y=new_observation(2);  %new data. It is not KF observation.������Կ������˲����Ĺ۲�
Z_obs=-y^2;                                 %This is the KF observation    ������ǿ������˲����Ĺ۲�

H=[x*x-y*y,x*y,x,y,1];
Z_hat=H*state;
%%�����е�Э������㷽�����ò���ûɶ���𣬵����Ҿ��������Ƶ�����ȷ
%A=state(1);B=state(2);C=1-state(1);D=state(3);E=state(4);F=state(5);  %ellipse coefficients ��Բϵ��
%Q=sigma_o*((2*A*x+B*y+D)^2+(2*C*y+B*x+E)^2);

Q=sigma_o;
K=p*(H')/(H*p*(H')+Q); % K coefficient �۲�ֵ������ϵ��

new_state=state+K*(Z_obs-Z_hat);
new_p=(eye(5)-K*H)*p;


end

