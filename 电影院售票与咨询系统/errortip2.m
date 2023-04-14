classdef errortip2 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Panel     matlab.ui.container.Panel
        Button    matlab.ui.control.Button
        Label     matlab.ui.control.Label
    end

   

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Name = 'Error';
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            delete(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [500 350 283 260];
            app.UIFigure.Name = 'MATLAB App';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.ForegroundColor = [1 0 0];
            app.Panel.Title = '错误信息：';
            app.Panel.Position = [-1 1 285 259];

            % Create Label
            app.Label = uilabel(app.Panel);
            app.Label.FontSize = 18;
            app.Label.FontColor = [1 0 0];
            app.Label.Position = [15 145 270 23];
            app.Label.Text = '鼠标控制按键重复，请重新选择！';

            % Create Button
            app.Button = uibutton(app.Panel, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [93 69 100 23];
            app.Button.Text = '确认';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = errortip2

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