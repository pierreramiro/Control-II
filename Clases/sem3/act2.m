[A,B,C,D]=tf2ss([1 2.5],conv([1 2.5],[1 -1]))
rank(ctrb(A,B)),rank(obsv(A,C))
%Para n=2. Es controlable pero no observable