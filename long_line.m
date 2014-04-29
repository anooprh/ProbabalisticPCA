function [] = long_line(xp, yp)
    a = (yp(2)-yp(1)) / (xp(2)-xp(1));
    b = yp(1)-a*xp(1);
    xlims = xlim(gca);
    ylims = ylim(gca);
    y = xlims*a+b;
    line( xlims, y );
    xlim(xlims);
    ylim(ylims);
end