classdef errortip3 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Panel     matlab.ui.container.Panel
        Label_2   matlab.ui.control.Label
        Label     matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Name = 'Error';
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 266 209];
            app.UIFigure.Name = 'MATLAB App';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.ForegroundColor = [1 0 0];
            app.Panel.Title = '错误信息：';
            app.Panel.Position = [1 1 266 209];

            % Create Label
            app.Label = uilabel(app.Panel);
            app.Label.FontSize = 20;
            app.Label.FontColor = [1 0 0];
            app.Label.Position = [63 105 145 25];
            app.Label.Text = '程序正在运行中';

            % Create Label_2
            app.Label_2 = uilabel(app.Panel);
            app.Label_2.FontSize = 20;
            app.Label_2.FontColor = [1 0 0];
            app.Label_2.Position = [63 68 145 25];
            app.Label_2.Text = '请先结束仿真！';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = errortip3

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

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