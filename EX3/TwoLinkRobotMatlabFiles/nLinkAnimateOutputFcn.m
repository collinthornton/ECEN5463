function status = nLinkAnimateOutputFcn(t,y,flag,L,w)
    n=numel(L);
    persistent TARGET_FIGURE link_handle

    status = 0;         % Assume stop button wasn't pushed.
    callbackDelay = 1;  % Check Stop button every 1 sec.

    % support odeplot(t,y) [v5 syntax]
    if nargin < 3 || isempty(flag)
        flag = '';
    elseif isstring(flag) && isscalar(flag)
        flag = char(flag);
    end

    switch(flag)

      case ''    % odeplot(t,y,'')

        if (isempty(TARGET_FIGURE) || isempty(link_handle))

            error(message('MATLAB:odeplot:NotCalledWithInit'));

        elseif (ishghandle(TARGET_FIGURE) && ishghandle(link_handle(1)))  % figure still open

            try
                ud = get(TARGET_FIGURE,'UserData');
                if ud.stop == 1  % Has stop button been pushed?
                    status = 1;
                else
                    for i = 1 : numel(t)
                        drawLink(y(1:n,i), L, w, link_handle);
                        title(['Simulation Time: ' num2str(t(end),'%2.2f') ' (s)']);
                        pause(0.01)
                    end
                end
            catch ME
                error(message('MATLAB:odeplot:ErrorUpdatingWindow', ME.message));
            end

        end

      case 'init'    % odeplot(tspan,y0,'init')

        f = figure(gcf); clf;
        TARGET_FIGURE = f;
        ud = get(f,'UserData');

        link_handle = drawLink(y(1:n), L, w, []);
        axis([-sum(L), sum(L), -sum(L), sum(L)]);

        % The STOP button
        h = findobj(f,'Tag','stop');
        if isempty(h)
            pos = get(0,'DefaultUicontrolPosition');
            pos(1) = pos(1) - 15;
            pos(2) = pos(2) - 15;
            uicontrol( ...
                'Style','pushbutton', ...
                'String',getString(message('MATLAB:odeplot:ButtonStop')), ...
                'Position',pos, ...
                'Callback',@StopButtonCallback, ...
                'Tag','stop');
            ud.stop = 0;
        else
            % make sure it's visible
            set(h,'Visible','on');
            % don't change old ud.stop status
            if ~ishold || ~isfield(ud,'stop')
                ud.stop = 0;
            end
        end

        % Set figure data
        ud.callbackTime = clock;
        set(f,'UserData',ud);

      case 'done'    % odeplot([],[],'done')
      clear TARGET_FIGURE link_handle
      otherwise

        error(message('MATLAB:odeplot:UnrecognizedFlag', flag));

    end  % switch flag

end  % odeplot

% --------------------------------------------------------------------------
% Sub-function
%

function StopButtonCallback(~,~)
    ud = get(gcbf,'UserData');
    ud.stop = 1;
    set(gcbf,'UserData',ud);
end  % StopButtonCallback
