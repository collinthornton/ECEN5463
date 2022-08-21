function nLinkAnimate(t,x,L,w,speed)
    link_handle = drawLink(x(1:numel(L),1), L, w, []);
        axis([-sum(L), sum(L), -sum(L), sum(L)]);
    for i=2:numel(t)
        drawLink(x(1:numel(L),i), L, w, link_handle);hold on
        title([' t= ''' num2str(t(i),'%.2f') '''']);
        pause((t(i)-t(i-1))/speed);
    end
end