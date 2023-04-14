classdef all_io_data < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Label     matlab.ui.control.Label
        UITable   matlab.ui.control.Table
    end

    


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Name = "模型总输入输出参数表格";
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.6353 0.0784 0.1843];
            app.UIFigure.Position = [100 100 802 505];
            app.UIFigure.Name = 'MATLAB App';

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.BackgroundColor = [1 1 1;0.9412 0.9412 0.9412];
            app.UITable.ColumnName = {'售票人员到达率'; '咨询人员到达率'; '电话人员到达率'; '现场售票服务时长参数'; '现场咨询服务时长参数'; '电话咨询服务时长参数'; '服务员的服务选择方式'; '售票服务的平均等待时间'; '现场咨询服务的平均等待时间'; '电话咨询的平均等待时间'; '服务员的工作时间占用率'};
            app.UITable.ColumnRearrangeable = 'on';
            app.UITable.RowName = {};
            app.UITable.Position = [1 0 802 480];

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.FontName = '楷体';
            app.Label.FontSize = 20;
            app.Label.FontColor = [1 1 1];
            app.Label.Position = [1 479 247 27];
            app.Label.Text = '模型总输入输出参数总表格';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = all_io_data

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