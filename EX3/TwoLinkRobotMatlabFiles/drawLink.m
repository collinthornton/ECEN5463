function handle = drawLink(theta, L, w, handle)
    pts = [0,       L(1),    L(1),   0;
           -w(1)/2, -w(1)/2, w(1)/2, w(1)/2];
    R = [cos(theta(1)), -sin(theta(1)); sin(theta(1)), cos(theta(1))];
    ptsprev = R*pts;
    cent = R*([L(1);0]);
    thetaabs = theta(1);
    X = ptsprev(1,:);
    Y = ptsprev(2,:);
    flag=0;
    if isempty(handle)
        handle = fill(X,Y,'b');
        hold on;
        flag=1;
    else
        set(handle(1),'XData',X,'YData',Y);
    end
    n=numel(L);
    if n>1
    for i=2:n
        Lt=L(i);
        wt=w(i);
        pts = [ 0,    Lt,   Lt,   0;
                -wt/2, -wt/2, +wt/2, +wt/2];
%         pts = pts+ptsprev(:,1); %translate to the end of previous link
        thetaabs=thetaabs + theta(i);
        R = [cos(thetaabs), -sin(thetaabs); sin(thetaabs), cos(thetaabs)];
        pts = R*pts+cent;
        cent = cent+R*[L(i);0];
        X = pts(1,:);
        Y = pts(2,:);
%         ptsprev = pts;
        if flag==1
            handle = [handle fill(X,Y,'b')];
        else
            set(handle(i),'XData',X,'YData',Y);
        end
    end
    end
    hold off
%     axis equal
end