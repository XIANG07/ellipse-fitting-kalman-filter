
function state = lssquare(x, y)
%lssquare :fit the ellipse eqution using Ls-Square method
% input: x 
% input: y 
% output: state ϵ��
% note: ��Բ����:state(1)*x^2+state(2)*(x*y)+(1-state(1))*y^2+state(3)*x+state(4)*y+state(5)=0 
%  ��С���˷������Բ
    X=[(x.*x-y.*y); (x.*y); (x);(y); (ones(size(x)))];
    Y=(-y.*y);
    state=pinv(X*X')*X*Y';%����ת�����׼����С���˷������෴������XY�ĸ�ʽԭ��
end

