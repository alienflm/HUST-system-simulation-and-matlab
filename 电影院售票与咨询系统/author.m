classdef author < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure         matlab.ui.Figure
        Button           matlab.ui.control.Button
        Panel_2          matlab.ui.container.Panel
        Label_4          matlab.ui.control.Label
        Label            matlab.ui.control.Label
        Panel            matlab.ui.container.Panel
        U202015108Label  matlab.ui.control.Label
        Label_3          matlab.ui.control.Label
        Label_2          matlab.ui.control.Label
    end

  
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Name = '作者介绍';
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
            app.UIFigure.Color = [0 0.4471 0.7412];
            app.UIFigure.Position = [100 100 675 511];
            app.UIFigure.Name = 'MATLAB App';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.TitlePosition = 'centertop';
            app.Panel.Title = '作者介绍';
            app.Panel.BackgroundColor = [0.0745 0.6235 1];
            app.Panel.FontName = '幼圆';
            app.Panel.FontWeight = 'bold';
            app.Panel.FontSize = 22;
            app.Panel.Position = [118 243 442 193];

            % Create Label_2
            app.Label_2 = uilabel(app.Panel);
            app.Label_2.FontName = '楷体';
            app.Label_2.FontSize = 20;
            app.Label_2.Position = [191 110 65 27];
            app.Label_2.Text = '曾恒宇';

            % Create Label_3
            app.Label_3 = uilabel(app.Panel);
            app.Label_3.FontName = '楷体';
            app.Label_3.FontSize = 20;
            app.Label_3.Position = [151 70 145 27];
            app.Label_3.Text = '人工智能2003班';

            % Create U202015108Label
            app.U202015108Label = uilabel(app.Panel);
            app.U202015108Label.FontName = '楷体';
            app.U202015108Label.FontSize = 20;
            app.U202015108Label.Position = [173 31 105 27];
            app.U202015108Label.Text = 'U202015108';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.FontName = '幼圆';
            app.Label.FontSize = 35;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [118 453 442 47];
            app.Label.Text = '电影院售票与咨询系统模型';

            % Create Panel_2
            app.Panel_2 = uipanel(app.UIFigure);
            app.Panel_2.TitlePosition = 'centertop';
            app.Panel_2.Title = '完成时间';
            app.Panel_2.BackgroundColor = [0.0745 0.6235 1];
            app.Panel_2.FontName = '幼圆';
            app.Panel_2.FontWeight = 'bold';
            app.Panel_2.FontSize = 22;
            app.Panel_2.Position = [118 41 442 193];

            % Create Label_4
            app.Label_4 = uilabel(app.Panel_2);
            app.Label_4.FontName = '楷体';
            app.Label_4.FontSize = 20;
            app.Label_4.Position = [71 83 299 27];
            app.Label_4.Text = '2023年1月1号——2023年2月28号';

            % Create Button
            app.Button = uibutton(app.UIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [620 0 56 27];
            app.Button.Text = '退出';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = author

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