classdef errortip4 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Panel     matlab.ui.container.Panel
        Label_3   matlab.ui.control.Label
        Label_2   matlab.ui.control.Label
        Label     matlab.ui.control.Label
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [500 350 262 217];
            app.UIFigure.Name = 'MATLAB App';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.ForegroundColor = [1 0 0];
            app.Panel.Title = '提示信息：';
            app.Panel.Position = [1 1 262 217];

            % Create Label
            app.Label = uilabel(app.Panel);
            app.Label.FontSize = 17;
            app.Label.FontColor = [1 0 0];
            app.Label.Position = [23 92 215 32];
            app.Label.Text = '到达率参数应选择在0-5之间';

            % Create Label_2
            app.Label_2 = uilabel(app.Panel);
            app.Label_2.FontSize = 17;
            app.Label_2.FontColor = [1 0 0];
            app.Label_2.Position = [41 46 180 32];
            app.Label_2.Text = '服务时长参数应大于0.2';

            % Create Label_3
            app.Label_3 = uilabel(app.Panel);
            app.Label_3.FontSize = 17;
            app.Label_3.FontColor = [1 0 0];
            app.Label_3.Position = [54 134 153 32];
            app.Label_3.Text = '为了避免影院拥堵：';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = errortip4

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end