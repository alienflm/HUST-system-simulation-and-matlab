classdef start_menu < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Menu      matlab.ui.container.Menu
        Menu_2    matlab.ui.container.Menu
        Label_2   matlab.ui.control.Label
        Button_2  matlab.ui.control.Button
        Button    matlab.ui.control.Button
        Label     matlab.ui.control.Label
        Image     matlab.ui.control.Image
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Name = '欢迎菜单界面';
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            run main.mlapp;
            delete(app);
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
            delete(app);
        end

        % Menu selected function: Menu
        function MenuSelected(app, event)
            run help.mlapp;
        end

        % Menu selected function: Menu_2
        function Menu_2Selected(app, event)
            run author.mlapp;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 638 474];
            app.UIFigure.Name = 'MATLAB App';

            % Create Menu
            app.Menu = uimenu(app.UIFigure);
            app.Menu.MenuSelectedFcn = createCallbackFcn(app, @MenuSelected, true);
            app.Menu.Text = '使用帮助';

            % Create Menu_2
            app.Menu_2 = uimenu(app.UIFigure);
            app.Menu_2.MenuSelectedFcn = createCallbackFcn(app, @Menu_2Selected, true);
            app.Menu_2.Text = '关于作者';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [1 -23 638 523];
            app.Image.ImageSource = '11.jpg';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.FontName = '幼圆';
            app.Label.FontSize = 35;
            app.Label.FontWeight = 'bold';
            app.Label.FontColor = [1 1 1];
            app.Label.Position = [100 413 442 47];
            app.Label.Text = '电影院售票与咨询系统模型';

            % Create Button
            app.Button = uibutton(app.UIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.BackgroundColor = [0.302 0.7451 0.9333];
            app.Button.FontName = '幼圆';
            app.Button.FontSize = 30;
            app.Button.FontWeight = 'bold';
            app.Button.Position = [79 118 164 70];
            app.Button.Text = '进入系统';

            % Create Button_2
            app.Button_2 = uibutton(app.UIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.BackgroundColor = [0.651 0.651 0.651];
            app.Button_2.FontName = '幼圆';
            app.Button_2.FontSize = 30;
            app.Button_2.FontWeight = 'bold';
            app.Button_2.Position = [395 118 164 70];
            app.Button_2.Text = '退出系统';

            % Create Label_2
            app.Label_2 = uilabel(app.UIFigure);
            app.Label_2.FontSize = 25;
            app.Label_2.FontColor = [1 1 1];
            app.Label_2.Position = [307 360 339 33];
            app.Label_2.Text = '--------人工智能2003班 曾恒宇';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = start_menu

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