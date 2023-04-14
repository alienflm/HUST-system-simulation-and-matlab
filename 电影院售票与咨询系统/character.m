classdef character < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Panel     matlab.ui.container.Panel
        Button    matlab.ui.control.Button
        tip       matlab.ui.control.Label
        key_call  matlab.ui.control.EditField
        Label_4   matlab.ui.control.Label
        key_ask   matlab.ui.control.EditField
        Label_2   matlab.ui.control.Label
        key_sale  matlab.ui.control.EditField
        Label     matlab.ui.control.Label
    end

    
    properties (Access = private)
        parent; %存储主界面app 
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, parent)
            app.parent = parent;
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            %判断是否只输入一个字符
            if length(app.key_sale.Value) == 1 && length(app.key_ask.Value) == 1 && length(app.key_call.Value) == 1
                %判断输入字符是否重复
                if strcmp(app.key_sale.Value,app.key_ask.Value)||strcmp(app.key_ask.Value,app.key_call.Value)||strcmp(app.key_sale.Value,app.key_call.Value)
                    run errortip.mlapp; %若输入字符重复，错误提示窗口弹出
                else
                    %将输入的键盘控制字符数据传递到主界面app属性
                    keyboard_input(app.parent,app.key_sale.Value,app.key_ask.Value,app.key_call.Value);
                    %更新主界面键盘控制字符信息
                    app.parent.sale_character.Text = app.key_sale.Value;
                    app.parent.ask_character.Text = app.key_ask.Value;
                    app.parent.call_character.Text = app.key_call.Value;
                    app.parent.sale_character.FontColor = 'r';
                    app.parent.ask_character.FontColor  = 'r';
                    app.parent.call_character.FontColor = 'r';
                    delete(app);
                end
            else
                run errortip.mlapp; %若同框内输入多个字符，错误提示窗口弹出
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [500 350 328 298];
            app.UIFigure.Name = 'MATLAB App';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.Title = '键盘输入确定字符控制';
            app.Panel.Position = [1 1 328 298];

            % Create Label
            app.Label = uilabel(app.Panel);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [62 212 89 22];
            app.Label.Text = '处理现场售票：';

            % Create key_sale
            app.key_sale = uieditfield(app.Panel, 'text');
            app.key_sale.Position = [166 212 100 22];

            % Create Label_2
            app.Label_2 = uilabel(app.Panel);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [62 162 89 22];
            app.Label_2.Text = '处理现场咨询：';

            % Create key_ask
            app.key_ask = uieditfield(app.Panel, 'text');
            app.key_ask.Position = [166 162 100 22];

            % Create Label_4
            app.Label_4 = uilabel(app.Panel);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.Position = [62 112 89 22];
            app.Label_4.Text = '处理电话咨询：';

            % Create key_call
            app.key_call = uieditfield(app.Panel, 'text');
            app.key_call.Position = [166 112 100 22];

            % Create tip
            app.tip = uilabel(app.Panel);
            app.tip.FontSize = 10;
            app.tip.FontColor = [1 0 0];
            app.tip.Position = [91 1 237 22];
            app.tip.Text = '提示：请输入对应控制字符（一个），注意不要重复';

            % Create Button
            app.Button = uibutton(app.Panel, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [114 49 100 23];
            app.Button.Text = '确认';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = character(varargin)

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