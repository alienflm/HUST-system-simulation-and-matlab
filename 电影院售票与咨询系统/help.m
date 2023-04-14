classdef help < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure      matlab.ui.Figure
        TabGroup      matlab.ui.container.TabGroup
        Tab           matlab.ui.container.Tab
        sLabel        matlab.ui.control.Label
        Label_12      matlab.ui.control.Label
        Label_11      matlab.ui.control.Label
        Label_9       matlab.ui.control.Label
        Label_2       matlab.ui.control.Label
        Label_6       matlab.ui.control.Label
        Label_3       matlab.ui.control.Label
        lamda05Label  matlab.ui.control.Label
        Label_4       matlab.ui.control.Label
        Image         matlab.ui.control.Image
        Label_5       matlab.ui.control.Label
        Label_7       matlab.ui.control.Label
        Image2        matlab.ui.control.Image
        Label_8       matlab.ui.control.Label
        Image3        matlab.ui.control.Image
        Label         matlab.ui.control.Label
        Tab_2         matlab.ui.container.Tab
        Label_15      matlab.ui.control.Label
        Label_14      matlab.ui.control.Label
        Image5        matlab.ui.control.Image
        Label_13      matlab.ui.control.Label
        Image4        matlab.ui.control.Image
        Label_10      matlab.ui.control.Label
        Tab_3         matlab.ui.container.Tab
        Image8        matlab.ui.control.Image
        Label_18      matlab.ui.control.Label
        Image7        matlab.ui.control.Image
        Image6        matlab.ui.control.Image
        Label_17      matlab.ui.control.Label
        Label_16      matlab.ui.control.Label
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Name = '使用帮助';
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.8 0.8 0.8];
            app.UIFigure.Position = [100 100 621 687];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 629 687];

            % Create Tab
            app.Tab = uitab(app.TabGroup);
            app.Tab.Title = '1';
            app.Tab.BackgroundColor = [0.2235 0.7216 0.5882];

            % Create Label
            app.Label = uilabel(app.Tab);
            app.Label.FontName = '楷体';
            app.Label.FontSize = 25;
            app.Label.Position = [258 623 105 40];
            app.Label.Text = '使用帮助';

            % Create Image3
            app.Image3 = uiimage(app.Tab);
            app.Image3.Position = [10 19 201 185];
            app.Image3.ImageSource = fullfile(pathToMLAPP, '3.png');

            % Create Label_8
            app.Label_8 = uilabel(app.Tab);
            app.Label_8.Position = [38 203 132 22];
            app.Label_8.Text = '（1）键盘控制字符输入';

            % Create Image2
            app.Image2 = uiimage(app.Tab);
            app.Image2.Position = [10 224 167 110];
            app.Image2.ImageSource = fullfile(pathToMLAPP, '2.png');

            % Create Label_7
            app.Label_7 = uilabel(app.Tab);
            app.Label_7.Position = [189 305 408 29];
            app.Label_7.Text = {'一共设置了四种服务员的服务方式，分别为系统自动服务，键盘控制服务，'; '按钮点击服务，鼠标左键、滚轮、右键控制服务'};

            % Create Label_5
            app.Label_5 = uilabel(app.Tab);
            app.Label_5.Position = [23 335 88 22];
            app.Label_5.Text = '2.选择服务方式';

            % Create Image
            app.Image = uiimage(app.Tab);
            app.Image.Position = [10 356 149 181];
            app.Image.ImageSource = fullfile(pathToMLAPP, '1.png');

            % Create Label_4
            app.Label_4 = uilabel(app.Tab);
            app.Label_4.Position = [176 405 433 29];
            app.Label_4.Text = {'其中服务时长均服从负指数分布，输入参数为单位时间内平均发生该事件的次数'; '建议不小于0.2为宜，否则等待人数过多造成拥堵'};

            % Create lamda05Label
            app.lamda05Label = uilabel(app.Tab);
            app.lamda05Label.Position = [176 479 442 29];
            app.lamda05Label.Text = {'其中人员到达均服从泊松分布，输入参数为lamda，即单位时间内产生的平均人数'; '建议0-5为宜，否则人数过多造成拥堵。'};

            % Create Label_3
            app.Label_3 = uilabel(app.Tab);
            app.Label_3.Position = [23 536 88 22];
            app.Label_3.Text = '1.输入相关参数';

            % Create Label_6
            app.Label_6 = uilabel(app.Tab);
            app.Label_6.FontSize = 15;
            app.Label_6.FontWeight = 'bold';
            app.Label_6.Position = [10 557 95 22];
            app.Label_6.Text = '输入初始条件';

            % Create Label_2
            app.Label_2 = uilabel(app.Tab);
            app.Label_2.BackgroundColor = [1 1 1];
            app.Label_2.FontColor = [0.6353 0.0784 0.1843];
            app.Label_2.Position = [1 593 627 22];
            app.Label_2.Text = ' 使用步骤：1.输入初始条件 2.确认仿真开始 3.待一定时间后结束仿真 4. 得到模型输出 5.重新回到1步骤进行仿真';

            % Create Label_9
            app.Label_9 = uilabel(app.Tab);
            app.Label_9.Position = [237 110 383 44];
            app.Label_9.Text = {'输入现场售票服务、现场咨询服务、电话咨询服务对应控制字符'; '注意提示：仅输入一个字符，且不要重复，否则会提示相应错误信息，'; '进行重新输入'};

            % Create Label_11
            app.Label_11 = uilabel(app.Tab);
            app.Label_11.Position = [189 265 423 29];
            app.Label_11.Text = {'系统自动服务：服务员根据优先级（现场售票=现场咨询>电话咨询）进行服务'; '其中现场售票和现场咨询同时有等待时随机选择'};

            % Create Label_12
            app.Label_12 = uilabel(app.Tab);
            app.Label_12.Position = [189 224 420 29];
            app.Label_12.Text = {'按键点击服务：由我们鼠标点击相应售票处或咨询处进行服务，服务的过程中'; '也严格遵循优先级，当售票和现场咨询有人时不能服务电话咨询'};

            % Create sLabel
            app.sLabel = uilabel(app.Tab);
            app.sLabel.FontColor = [0.6353 0.0784 0.1843];
            app.sLabel.Position = [176 515 138 22];
            app.sLabel.Text = '本模型设定单位时间为5s';

            % Create Tab_2
            app.Tab_2 = uitab(app.TabGroup);
            app.Tab_2.Title = '2';
            app.Tab_2.BackgroundColor = [0.2235 0.7216 0.5882];

            % Create Label_10
            app.Label_10 = uilabel(app.Tab_2);
            app.Label_10.Position = [38 623 112 22];
            app.Label_10.Text = '2.鼠标控制按键选择';

            % Create Image4
            app.Image4 = uiimage(app.Tab_2);
            app.Image4.Position = [10 437 201 187];
            app.Image4.ImageSource = fullfile(pathToMLAPP, '4.png');

            % Create Label_13
            app.Label_13 = uilabel(app.Tab_2);
            app.Label_13.Position = [217 578 408 29];
            app.Label_13.Text = {'根据下拉菜单选择对应服务的鼠标控制按键，注意不要重复选择，否则会提'; '示相应错误信息'};

            % Create Image5
            app.Image5 = uiimage(app.Tab_2);
            app.Image5.Position = [23 224 177 210];
            app.Image5.ImageSource = fullfile(pathToMLAPP, '5.png');

            % Create Label_14
            app.Label_14 = uilabel(app.Tab_2);
            app.Label_14.Position = [211 405 420 29];
            app.Label_14.Text = {'在页面左下方显示了对应的控制信息，以键盘选择对应字符为例，如果绿灯亮'; '起则代表未选中‘键盘选择’，红灯亮起则代表选中‘键盘选择’。'};

            % Create Label_15
            app.Label_15 = uilabel(app.Tab_2);
            app.Label_15.BackgroundColor = [1 1 1];
            app.Label_15.FontColor = [1 0 0];
            app.Label_15.Position = [1 182 620 22];
            app.Label_15.Text = '                                                           最后点击‘确认仿真开始’按钮进行仿真';

            % Create Tab_3
            app.Tab_3 = uitab(app.TabGroup);
            app.Tab_3.Title = '3';
            app.Tab_3.BackgroundColor = [0.2235 0.7216 0.5882];

            % Create Label_16
            app.Label_16 = uilabel(app.Tab_3);
            app.Label_16.FontSize = 15;
            app.Label_16.FontWeight = 'bold';
            app.Label_16.Position = [10 623 95 22];
            app.Label_16.Text = '得到模型输出';

            % Create Label_17
            app.Label_17 = uilabel(app.Tab_3);
            app.Label_17.Position = [196 546 426 44];
            app.Label_17.Text = {'点击‘仿真结束确认’按钮后，得到相应模型输出，同时在模型输出面板上方显示'; '着实时时间，同时在该面板下方存在着模型状态面板，实时显示着影院存在的总'; '人数和此刻进影院的人数'};

            % Create Image6
            app.Image6 = uiimage(app.Tab_3);
            app.Image6.Position = [10 182 180 433];
            app.Image6.ImageSource = fullfile(pathToMLAPP, '10.png');

            % Create Image7
            app.Image7 = uiimage(app.Tab_3);
            app.Image7.Position = [12 19 178 150];
            app.Image7.ImageSource = fullfile(pathToMLAPP, '8.png');

            % Create Label_18
            app.Label_18 = uilabel(app.Tab_3);
            app.Label_18.Position = [196 193 426 44];
            app.Label_18.Text = '同时可以点击‘模型总输入输出参数表格‘按钮，查找历来仿真的输入输出数据';

            % Create Image8
            app.Image8 = uiimage(app.Tab_3);
            app.Image8.Position = [196 253 417 290];
            app.Image8.ImageSource = fullfile(pathToMLAPP, '9.png');

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = help

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