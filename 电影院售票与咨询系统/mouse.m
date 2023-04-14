classdef mouse < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Panel     matlab.ui.container.Panel
        Button    matlab.ui.control.Button
        call      matlab.ui.control.DropDown
        Label_3   matlab.ui.control.Label
        ask       matlab.ui.control.DropDown
        Label_2   matlab.ui.control.Label
        sale      matlab.ui.control.DropDown
        Label     matlab.ui.control.Label
    end

    
    properties (Access = private)
        parent % 存储主界面app
    end

    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, parent)
            app.parent = parent;
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            %判断是否选择重复
            if strcmp(app.sale.Value,app.ask.Value)||strcmp(app.sale.Value,app.call.Value)||strcmp(app.ask.Value,app.call.Value)
                run errortip3.mlapp; %如果选择重复则错误提示窗口弹出
            else
                %更新主界面对应鼠标控制按键信息
                app.parent.sale_button.Text = app.sale.Value; 
                app.parent.ask_button.Text = app.ask.Value;
                app.parent.call_button.Text = app.call.Value;
                app.parent.sale_button.FontColor = 'r';
                app.parent.ask_button.FontColor = 'r';
                app.parent.call_button.FontColor = 'r';
                mouse_input(app.parent,app); %将选择的鼠标控制按键数据传递到主界面app属性
                delete(app);
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [500 350 336 292];
            app.UIFigure.Name = 'MATLAB App';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.Title = '鼠标按键控制选择';
            app.Panel.Position = [1 1 336 292];

            % Create Label
            app.Label = uilabel(app.Panel);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [84 213 53 22];
            app.Label.Text = '现场售票';

            % Create sale
            app.sale = uidropdown(app.Panel);
            app.sale.Items = {'left', 'middle', 'right'};
            app.sale.Position = [152 213 100 22];
            app.sale.Value = 'left';

            % Create Label_2
            app.Label_2 = uilabel(app.Panel);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [84 161 53 22];
            app.Label_2.Text = '现场咨询';

            % Create ask
            app.ask = uidropdown(app.Panel);
            app.ask.Items = {'left', 'middle', 'right'};
            app.ask.Position = [152 161 100 22];
            app.ask.Value = 'middle';

            % Create Label_3
            app.Label_3 = uilabel(app.Panel);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.Position = [84 111 53 22];
            app.Label_3.Text = '电话咨询';

            % Create call
            app.call = uidropdown(app.Panel);
            app.call.Items = {'left', 'middle', 'right'};
            app.call.Position = [152 111 100 22];
            app.call.Value = 'right';

            % Create Button
            app.Button = uibutton(app.Panel, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [118 46 100 23];
            app.Button.Text = '确认';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mouse(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

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