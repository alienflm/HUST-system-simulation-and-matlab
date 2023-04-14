classdef main < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        Panel_2                   matlab.ui.container.Panel
        enter_people_num_text     matlab.ui.control.Label
        enter_people_num_label    matlab.ui.control.Label
        all_people_num_text       matlab.ui.control.Label
        all_people_num_label      matlab.ui.control.Label
        server_area_label         matlab.ui.control.Label
        gate_label                matlab.ui.control.Label
        call_label_button         matlab.ui.control.Button
        ask_label_button          matlab.ui.control.Button
        Lamp                      matlab.ui.control.Lamp
        sale_label_button         matlab.ui.control.Button
        call_people_allnum_text   matlab.ui.control.Label
        call_people_allnum_label  matlab.ui.control.Label
        call_people_bk            matlab.ui.control.Label
        ask_people_allnum_text    matlab.ui.control.Label
        sale_people_allnum_text   matlab.ui.control.Label
        ask_people_allnum_label   matlab.ui.control.Label
        sale_people_allnum_label  matlab.ui.control.Label
        Panel                     matlab.ui.container.Panel
        help_button               matlab.ui.control.Button
        mouse_button              matlab.ui.container.Panel
        Lamp3                     matlab.ui.control.Lamp
        call_button               matlab.ui.control.Label
        ask_button                matlab.ui.control.Label
        sale_button               matlab.ui.control.Label
        call_label2               matlab.ui.control.Label
        ask_label2                matlab.ui.control.Label
        sale_label2               matlab.ui.control.Label
        call_time_rate            matlab.ui.control.NumericEditField
        Label_13                  matlab.ui.control.Label
        ask_time_rate             matlab.ui.control.NumericEditField
        Label_12                  matlab.ui.control.Label
        sale_time_rate            matlab.ui.control.NumericEditField
        Label_11                  matlab.ui.control.Label
        call_rate                 matlab.ui.control.NumericEditField
        Label_6                   matlab.ui.control.Label
        ask_rate                  matlab.ui.control.NumericEditField
        Label_5                   matlab.ui.control.Label
        sale_rate                 matlab.ui.control.NumericEditField
        Label_4                   matlab.ui.control.Label
        start                     matlab.ui.control.Button
        keyboard_character        matlab.ui.container.Panel
        Lamp2                     matlab.ui.control.Lamp
        call_character            matlab.ui.control.Label
        ask_character             matlab.ui.control.Label
        sale_character            matlab.ui.control.Label
        call_label                matlab.ui.control.Label
        ask_label                 matlab.ui.control.Label
        sale_label                matlab.ui.control.Label
        selectGroup               matlab.ui.container.ButtonGroup
        mouse_select_button       matlab.ui.control.Button
        mouse_select              matlab.ui.control.RadioButton
        keyboard_select_button    matlab.ui.control.Button
        button_select             matlab.ui.control.RadioButton
        keyboard_select           matlab.ui.control.RadioButton
        system_select             matlab.ui.control.RadioButton
        cinema                    matlab.ui.control.Label
        Panel_3                   matlab.ui.container.Panel
        all_io_data_button        matlab.ui.control.Button
        percent_label             matlab.ui.control.Label
        server_occupy             matlab.ui.control.Label
        server_occupy_label       matlab.ui.control.Label
        sLabel_3                  matlab.ui.control.Label
        sLabel_2                  matlab.ui.control.Label
        sLabel                    matlab.ui.control.Label
        call_period               matlab.ui.control.Label
        ask_period                matlab.ui.control.Label
        sale_period               matlab.ui.control.Label
        call_period_label         matlab.ui.control.Label
        ask_period_label          matlab.ui.control.Label
        sale_period_label         matlab.ui.control.Label
        time_label                matlab.ui.control.Label
        time                      matlab.ui.control.Label
        endButton                 matlab.ui.control.Button
        sale_people_bk            matlab.ui.control.Label
        ask_people_bk             matlab.ui.control.Label
        draw_2                    matlab.ui.control.UIAxes
        draw                      matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        Property % Description
        enter_people_num = 0; %此刻进入电影院的人数
        sale_people_num = 0;  %此刻进入电影院买票的人数
        ask_people_num = 0;   %此刻进入电影院咨询的人数
        call_people_num = 0;  %此刻电话咨询的人数
        all_people_num = 0;   %在电影院的总人数
        sale_people_allnum = 0; %等待买票的总人数
        ask_people_allnum = 0;  %等待现场咨询的总人数
        call_people_allnum = 0; %等待电话咨询的总人数
        process_sale_num = 0; %已经处理完售票的人数
        process_ask_num = 0; %已经处理完现场咨询的人数
        process_call_num = 0; %已经处理完电话咨询的人数
        people_dest=[]; %每次进来的人的目的地
        people_interval = 6; %进入口每个人的间隔
        stop_simulate = 0; %是否停止仿真
        server_laststate = 0; %服务员的上一状态
        server_state = 0; %服务员的现在状态
        datetimer2; %定时器2
        key_sale='a'; %键盘控制字符，'a'对应处理售票
        key_ask='s'; %键盘控制字符，'s'对应处理现场咨询
        key_call='d'; %键盘控制字符，'d'对应处理电话咨询
        server_sale_time = []; %售票处的每个人等待时间列表
        server_ask_time = [];  %现场咨询处的每个人等待时间列表
        server_call_time = []; %电话咨询处的每个人等待时间列表
        server_time = 0; %服务员的工作时间
        server_sale_pause_list = []; %服务员服务每个买票人的时间列表
        server_ask_pause_list =[]; %服务员服务每个现场咨询人的时间列表
        server_call_pause_list = []; %服务员服务每个电话咨询人的时间列表
        mouse_dir=struct('left',1,'middle',2,'right',3); %鼠标控制按键
        work_state = 0;
    end
    
    properties (Access = public)
       %模型历来仿真的输入输出参数列表
        input_output=[];
        subtable;
    end
    
    methods (Access = private)
        
        function draw_people(app,x,y) %画人
            people_size = 3 ;
            rectangle(app.draw,'Position',[x,y,people_size,people_size],'LineWidth',1,'EdgeColor','r','FaceColor','r');
            text(app.draw,x,y+people_size/2,'人','Color','white');
        end
        
        function draw_server(app,x,y) %画服务员
            server_length = 14;
            server_width  = 5;
            rectangle(app.draw_2,'Position',[x,y,server_width,server_length],'LineWidth',1,'EdgeColor','black','FaceColor','black');
            text(app.draw_2,x+1,y+server_length/2,{'服','务','员'},'FontSize',15,'Color','white');
        end

        function people_move(app,where) %人移动
            dest_x = 90;
            dest_y = [];
            %生成此刻进来人的初始y坐标
            original_y = (-app.ask_people_num)*app.people_interval:app.people_interval:(app.sale_people_num-1)*app.people_interval;
            original_y = fliplr(original_y);%翻转一下
            for i=1:length(where)
                %根据每个人的不同去向选择不同y坐标
                if where(i) == 0
                    dest_y = [dest_y 35];
                elseif where(i) == 1
                    dest_y = [dest_y 7];
                end
            end
            %运动更新到对应位置
            x = linspace(0,dest_x,25);
            if ~isempty(dest_y) %判断此时是否无人
                k = (dest_y-original_y)/dest_x;
                b = dest_y-k*dest_x;
                y = k'.*x+b';
                for i=1:length(x)
                    h = get(app.draw, 'children');
                    for j=1:app.enter_people_num
                        delete(h(2*j-1));
                        delete(h(2*j));
                    end
                    for j=1:app.enter_people_num
                        draw_people(app,x(i),y(j,i));
                    end                
                    pause(0.0001);
                end
            end
        end
        
        function timer_init(app) %定时器1初始化
            datetimer = timer;
            datetimer.StartDelay = 0;
            datetimer.Period = 1;
            datetimer.ExecutionMode = 'fixedRate';
            datetimer.BusyMode = 'queue';
            datetimer.TimerFcn = @(~,~) get_current_time(app);
            start(datetimer);
        end

        function timer2_init(app) %定时器2初始化
            app.datetimer2 = timer;
            app.datetimer2.StartDelay = 0;
            app.datetimer2.Period = 5; %设置单位时间为5s
            app.datetimer2.ExecutionMode = 'fixedRate';
            app.datetimer2.BusyMode = 'queue';
            app.datetimer2.TimerFcn = @(~,~) generate_people_num(app);
            start(app.datetimer2);
        end

        
        function get_current_time(app) %获取当前时间
            T = clock;
            set(app.time,'Text',[num2str(T(4)),':',num2str(T(5))]);
        end

        function generate_people_num(app) %产生顾客人数并移动至对应位置
            %生成三种人数，服从泊松分布
            app.sale_people_num = random('poisson',app.sale_rate.Value,1);
            app.ask_people_num = random('poisson',app.ask_rate.Value,1);
            app.call_people_num = random('poisson',app.call_rate.Value,1);
            %在影院的各类总人数计算
            app.enter_people_num = app.sale_people_num + app.ask_people_num;
            app.sale_people_allnum = app.sale_people_allnum + app.sale_people_num;
            app.ask_people_allnum = app.ask_people_allnum + app.ask_people_num;
            app.call_people_allnum = app.call_people_allnum + app.call_people_num;
            app.all_people_num = app.all_people_num + app.enter_people_num;
            %数量可视化
            app.all_people_num_text.Text = string(app.all_people_num);
            app.enter_people_num_text.Text = string(app.enter_people_num);
            %生成对应去向
            app.people_dest = zeros(1,app.sale_people_num);
            app.people_dest = [app.people_dest ones(1,app.ask_people_num)];
            for i=1:app.sale_people_num
                draw_people(app,0,(i-1)*app.people_interval);
            end
            for i=1:app.ask_people_num
                draw_people(app,0,-i*app.people_interval);
            end
            people_move(app,app.people_dest); %运动更新到相应位置
            app.sale_people_allnum_text.Text = string(app.sale_people_allnum);
            app.ask_people_allnum_text.Text = string(app.ask_people_allnum);
            app.call_people_allnum_text.Text = string(app.call_people_allnum);
            %电话咨询有人，指示灯亮红灯
            if app.call_people_allnum>0
                app.Lamp.Color = 'r';
            end
            %记录到达的人开始等待的时间
            nowtime = ones(1,app.sale_people_num)*toc;
            app.server_sale_time = [app.server_sale_time nowtime];
            nowtime = ones(1,app.ask_people_num)*toc;
            app.server_ask_time = [app.server_ask_time nowtime];
            nowtime = ones(1,app.call_people_num)*toc;
            app.server_call_time = [app.server_call_time nowtime];
        end

        
        function server_process(app) %服务员处理函数
            switch app.server_state
                case 1
                    app.process_sale_num = app.process_sale_num + 1;
                    app.server_sale_time(app.process_sale_num) =  toc - app.server_sale_time(app.process_sale_num) ; %获取等待时间
                    pausetime = exprnd(app.sale_time_rate.Value); %负指数分布处理时间
                    pause(pausetime);
                    app.sale_people_allnum = app.sale_people_allnum - 1; %处理完人数减一
                    app.sale_people_allnum_text.Text = string(app.sale_people_allnum); %更新可视化数量
                    app.server_sale_pause_list = [app.server_sale_pause_list pausetime]; %处理时间列表
                case 2
                    app.process_ask_num = app.process_ask_num + 1;
                    app.server_ask_time(app.process_ask_num) = toc - app.server_ask_time(app.process_ask_num); %获取等待时间
                    pausetime = exprnd(app.ask_time_rate.Value); %负指数分布处理时间
                    pause(pausetime);
                    app.ask_people_allnum = app.ask_people_allnum - 1; %处理完人数减一
                    app.ask_people_allnum_text.Text = string(app.ask_people_allnum); %更新可视化数量     
                    app.server_ask_pause_list = [app.server_ask_pause_list pausetime]; %处理时间列表
                case 3
                    app.process_call_num = app.process_call_num + 1;
                    app.server_call_time(app.process_call_num) = toc - app.server_call_time(app.process_call_num); %获取等待时间
                    pausetime = exprnd(app.call_time_rate.Value); %负指数分布处理时间
                    pause(pausetime);
                    app.call_people_allnum = app.call_people_allnum - 1; %处理完人数减一
                    app.call_people_allnum_text.Text = string(app.call_people_allnum); %更新可视化数量
                    app.server_call_pause_list = [app.server_call_pause_list pausetime]; %处理时间列表
            end
            if app.call_people_allnum == 0
                app.Lamp.Color = 'g'; %无人电话，则绿灯亮
            end            
        end
        
        function initialize(app)
            app.enter_people_num = 0; %此刻进入电影院的人数
            app.sale_people_num = 0;  %此刻进入电影院买票的人数
            app.ask_people_num = 0;   %此刻进入电影院咨询的人数
            app.call_people_num = 0;  %此刻电话咨询的人数
            app.all_people_num = 0;   %在电影院的总人数
            app.sale_people_allnum = 0; %等待买票的总人数
            app.ask_people_allnum = 0;  %等待现场咨询的总人数
            app.call_people_allnum = 0; %等待电话咨询的总人数
            app.process_sale_num = 0; %已经处理完售票的人数
            app.process_ask_num = 0; %已经处理完现场咨询的人数
            app.process_call_num = 0; %已经处理完电话咨询的人数
            app.people_dest=[]; %每次进来的人的目的地
            app.people_interval = 6; %进入口每个人的间隔
            app.stop_simulate = 0; %是否停止仿真
            app.server_laststate = 0; %服务员的上一状态
            app.server_state = 0; %服务的现在状态
            app.server_sale_time = []; %售票处的每个人等待时间列表
            app.server_ask_time = [];  %现场咨询处的每个人等待时间列表
            app.server_call_time = []; %电话咨询处的每个人等待时间列表
            app.server_time = 0; %服务员的工作时间
            app.server_sale_pause_list = []; %服务员服务每个买票人的时间列表
            app.server_ask_pause_list =[]; %服务员服务每个现场咨询人的时间列表
            app.server_call_pause_list = []; %服务员服务每个电话咨询人的时间列表
            %服务员回到原点
            h = get(app.draw_2, 'children');
            delete(h);
            draw_server(app,30,-7);
            %输出清零
            app.sale_period.Text = '';
            app.ask_period.Text = '';
            app.call_period.Text = '';
            app.server_occupy.Text ='';
        end
        
        function not_system_process(app,server_x,server_y,dest_x,sale_y,ask_y,call_y,pausetime,update_rate)
            while(1)
                pause(0.000001); %暂停极小一段时间留以程序反应，使得能够终止仿真
                if app.stop_simulate == 1
                    stop(app.datetimer2); %暂停定时器2
                    delete(app.datetimer2); %删除定时器2
                    app.work_state = 0;
                    break
                end
                if (app.sale_people_allnum + app.ask_people_allnum) > 0 %如果影院里仍然有人的话
                    %根据选择的状态是否有人，来进行后续操作
                    if (app.server_state == 1 && app.sale_people_allnum>0) || (app.server_state == 2 && app.ask_people_allnum>0)
                        switch app.server_state
                            case 1
                                dest_y = sale_y;
                            case 2
                                dest_y = ask_y ;
                        end
                        if app.server_laststate == 0 %服务员上一状态在初始位置
                            %运动更新到对应位置
                            x = linspace(server_x,dest_x,update_rate);
                            k = (dest_y-server_y)/(dest_x-server_x);
                            b = dest_y- k * dest_x;
                            y = k*x+b;
                            for i=1:length(x)
                                h = get(app.draw_2, 'children');
                                delete(h);
                                draw_server(app,x(i),y(i));
                                pause(pausetime);
                            end
                        elseif app.server_laststate ~= app.server_state %服务员的位置发生变化
                            %判断服务员的上一状态位置
                            switch app.server_laststate
                                case 1
                                    source_y = sale_y;
                                case 2
                                    source_y = ask_y;
                                case 3
                                    source_y = call_y;
                            end
                            %运动更新到对应位置
                            y = linspace(source_y,dest_y,update_rate);
                            for i=1:length(y)
                                h = get(app.draw_2,'children');
                                delete(h);
                                draw_server(app,dest_x,y(i));
                                pause(pausetime);
                            end                               
                        end
                        app.server_laststate = app.server_state;
                        server_process(app);                           
                    end
                else
                    if app.call_people_allnum > 0
                        if app.server_state == 3
                            dest_y = call_y;
                            if app.server_laststate == 0 %服务员上一状态在初始位置
                                %运动更新到对应位置
                                x = linspace(server_x,dest_x,update_rate);
                                k = (dest_y-server_y)/(dest_x-server_x);
                                b = dest_y- k * dest_x;
                                y = k*x+b;
                                for i=1:length(x)
                                    h = get(app.draw_2, 'children');
                                    delete(h);
                                    draw_server(app,x(i),y(i));
                                    pause(pausetime);
                                end
                            elseif app.server_laststate == 1 %服务员上一状态在现场售票处
                                %运动更新到对应位置
                                y = linspace(sale_y,call_y,update_rate);
                                for i=1:length(y)
                                    h = get(app.draw_2, 'children');
                                    delete(h);
                                    draw_server(app,dest_x,y(i));
                                    pause(pausetime);
                                end
                            elseif app.server_laststate == 2 %服务员上一状态在现场咨询处
                                %运动更新到对应位置
                                y = linspace(ask_y,call_y,update_rate);
                                for i=1:length(y)
                                    h = get(app.draw_2, 'children');
                                    delete(h);                                   
                                    draw_server(app,dest_x,y(i));
                                    pause(pausetime);
                                end
                            end
                            app.server_laststate = app.server_state;
                            server_process(app);                               
                        end
                    else
                        %如果都没有人的话服务员回到初始位置
                        if app.server_state ~=0
                            app.server_state =0;
                            app.server_laststate = app.server_state;
                            %运动更新到对应位置
                            x = linspace(dest_x,server_x,update_rate);
                            k = (dest_y - server_y)/(dest_x - server_x);
                            b = dest_y - k * dest_x;
                            y = k * x + b;
                            for i=1:length(x)
                                h = get(app.draw_2, 'children');
                                delete(h);                               
                                draw_server(app,x(i),y(i));
                                pause(pausetime);
                            end
                        end                            
                    end
                end    
            end            
        end  
    end

    
    methods (Access = public)
        
        function keyboard_input(app,key_sale,key_ask,key_call) %将输入的键盘控制字符数据传递到主界面app属性
            app.key_sale = key_sale;
            app.key_ask  = key_ask;
            app.key_call = key_call;
        end
        
        function mouse_input(app,subfigure) %将选择的鼠标控制按键数据传递到主界面app属性
            app.mouse_dir=struct(subfigure.sale.Value,1,subfigure.ask.Value,2,subfigure.call.Value,3);  
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Name = '电影院售票与咨询系统';
            stop(timerfind); %暂停所有计时器
            delete(timerfind); %删除所有计时器
            timer_init(app); %开启定时器1
            draw_server(app,30,-7); %画出服务员初始位置
        end

        % Button pushed function: start
        function startButtonPushed(app, event)
            if app.work_state
                 run errortip3.mlapp;
            elseif app.sale_rate.Value<0||app.sale_rate.Value>5||...
                    app.ask_rate.Value<0||app.ask_rate.Value>5||...
                    app.call_rate.Value<0||app.call_rate.Value>5||...
                    app.sale_time_rate.Value<0.2||app.ask_time_rate.Value<0.2||app.call_time_rate.Value<0.2
                run errortip4.mlapp;
            else
                app.stop_simulate = 0;
                app.work_state = 1;
                initialize(app);
                server_x = 30; %服务员的初始位置
                server_y = -7;
                sale_y   = 29; %售票处位置
                ask_y    =  0; %现场咨询处位置
                call_y   =-29; %电话咨询处位置
                dest_x   =  7; %服务员处理位置的横坐标
                pausetime = 0.0001; %人和服务员运动更新暂停时间
                update_rate = 10; %决定人和服务员的运动速度
                tic %开始计时
                timer2_init(app); %开启定时器2，进行仿真
                if app.system_select.Value %服务员系统自动产生服务
                    while(1)
                        pause(0.000001); %暂停极小一段时间留以程序反应，使得能够终止仿真
                        if app.stop_simulate == 1 
                            stop(app.datetimer2); %暂停定时器2
                            delete(app.datetimer2); %删除定时器2
                            app.work_state = 0;
                            break
                        end
                        if (app.sale_people_allnum + app.ask_people_allnum) > 0 %如果影院里仍然有人的话
                            app.server_laststate = app.server_state;
                            if app.sale_people_allnum == 0 %售票处没人
                                dest_y = ask_y;
                                app.server_state = 2; %去现场咨询处
                            elseif app.ask_people_allnum == 0 %现场咨询处没人
                                dest_y = sale_y;
                                app.server_state = 1; %去现场售票处
                            else
                                %二者随机选择
                                if rand(1) > 0.5
                                    dest_y = sale_y;
                                    app.server_state = 1; %在现场售票处
                                else
                                    dest_y = ask_y;
                                    app.server_state = 2; %在现场咨询处
                                end                            
                            end
                            if app.server_laststate == 0 %服务员上一状态在初始位置
                                %运动更新到对应位置
                                x = linspace(server_x,dest_x,update_rate);
                                k = (dest_y-server_y)/(dest_x-server_x);
                                b = dest_y- k * dest_x;
                                y = k*x+b;
                                for i=1:length(x)
                                    h = get(app.draw_2, 'children');
                                    delete(h);
                                    draw_server(app,x(i),y(i));
                                    pause(pausetime);
                                end
                            elseif app.server_laststate ~= app.server_state %服务员的位置发生变化
                                %判断服务员的上一状态位置
                                switch app.server_laststate
                                    case 1
                                        source_y = sale_y; 
                                    case 2
                                        source_y = ask_y;
                                    case 3
                                        source_y = call_y;
                                end
                                %运动更新到对应位置
                                y = linspace(source_y,dest_y,update_rate);
                                for i=1:length(y)
                                    h = get(app.draw_2,'children');
                                    delete(h);
                                    draw_server(app,dest_x,y(i));
                                    pause(pausetime);
                                end
                            end
                            server_process(app);
                        else
                            if app.call_people_allnum > 0 %电话咨询处有人等待
                                app.server_laststate = app.server_state;
                                app.server_state = 3;
                                dest_y = call_y;
                                switch app.server_laststate
                                    case 0 %服务员上一状态在初始位置
                                        %运动更新到对应位置
                                        x = linspace(server_x,dest_x,update_rate);
                                        k = (dest_y-server_y)/(dest_x-server_x);
                                        b = dest_y- k * dest_x;
                                        y = k*x+b;
                                        for i=1:length(x)
                                            h = get(app.draw_2, 'children');
                                            delete(h);
                                            draw_server(app,x(i),y(i));
                                            pause(pausetime);
                                        end                                    
                                    case 1 %服务员上一状态在现场售票处
                                        %运动更新到对应位置
                                        y = linspace(sale_y,call_y,update_rate);
                                        for i=1:length(y)
                                            h = get(app.draw_2, 'children');
                                            delete(h);
                                            draw_server(app,dest_x,y(i));
                                            pause(pausetime);
                                        end                                   
                                    case 2 %服务员上一状态在现场咨询处
                                        %运动更新到对应位置
                                        y = linspace(ask_y,call_y,update_rate);
                                        for i=1:length(y)
                                            h = get(app.draw_2, 'children');
                                            delete(h);                                   
                                            draw_server(app,dest_x,y(i));
                                            pause(pausetime);
                                        end
                                end
                                server_process(app);
                            else
                                %如果都没有人的话服务员回到初始位置
                                if app.server_state ~=0 
                                    app.server_state =0;
                                    %运动更新到对应位置
                                    x = linspace(dest_x,server_x,update_rate);
                                    k = (dest_y - server_y)/(dest_x - server_x);
                                    b = dest_y - k * dest_x;
                                    y = k * x + b;
                                    for i=1:length(x)
                                        h = get(app.draw_2, 'children');
                                        delete(h);                               
                                        draw_server(app,x(i),y(i));
                                        pause(pausetime);
                                    end
                                end                            
                            end
                        end
                    end
                else
                    %非系统自动产生服务处理函数
                    not_system_process(app,server_x,server_y,dest_x,sale_y,ask_y,call_y,pausetime,update_rate);           
                end
            end
        end

        % Button pushed function: endButton
        function endButtonPushed(app, event)
            if ~app.work_state
                run errortip5.mlapp;
            else
                app.server_time = toc; %记录服务员的总工作时间
                app.stop_simulate = 1 ; %停止仿真
                rate = (sum(app.server_sale_pause_list)+sum(app.server_ask_pause_list)+sum(app.server_call_pause_list))/app.server_time; %计算服务员工作时间的占用率
                app.server_occupy.Text = string(rate*100); 
                %计算各类服务的平均等待时间
                if app.process_sale_num
                    app.server_sale_time = sum(app.server_sale_time(1:app.process_sale_num))/app.process_sale_num;
                end
                if app.process_ask_num
                    app.server_ask_time = sum(app.server_ask_time(1:app.process_ask_num))/app.process_ask_num;
                end
                if app.process_call_num
                    app.server_call_time = sum(app.server_call_time(1:app.process_call_num))/app.process_call_num;
                end
                app.sale_period.Text = string(app.server_sale_time);
                app.ask_period.Text = string(app.server_ask_time);
                app.call_period.Text = string(app.server_call_time);
                if app.system_select.Value
                    server_mode ='系统选择';
                elseif app.keyboard_select.Value
                    server_mode = '键盘选择';
                elseif app.button_select.Value
                    server_mode = '按钮选择';
                elseif app.mouse_select.Value
                    server_mode = '鼠标选择';
                end            
                app.input_output = [app.input_output;{app.sale_rate.Value,app.ask_rate.Value,app.call_rate.Value,...
                    app.sale_time_rate.Value,app.ask_time_rate.Value,app.call_time_rate.Value,...
                    server_mode,app.server_sale_time,app.server_ask_time,app.server_call_time,rate*100}];  
            end          
        end

        % Button pushed function: sale_label_button
        function sale_label_buttonButtonPushed(app, event)
            if app.button_select.Value && app.sale_people_allnum > 0  
                app.server_state = 1;
            end
        end

        % Button pushed function: ask_label_button
        function ask_label_buttonButtonPushed(app, event)
            if app.button_select.Value && app.ask_people_allnum > 0
                app.server_state = 2;
            end            
        end

        % Button pushed function: call_label_button
        function call_label_buttonButtonPushed(app, event)
            if app.button_select.Value && app.call_people_allnum > 0 && ((app.sale_people_allnum + app.ask_people_allnum) == 0)
                app.server_state = 3;
            end            
        end

        % Selection changed function: selectGroup
        function selectGroupSelectionChanged(app, event)
            if app.keyboard_select.Value
                app.Lamp2.Color = 'r';
                app.Lamp3.Color = 'g';
            elseif app.mouse_select.Value
                app.Lamp3.Color = 'r';
                app.Lamp2.Color = 'g';
            else
                app.Lamp2.Color = 'g';
                app.Lamp3.Color = 'g';
            end
        end

        % Button pushed function: keyboard_select_button
        function keyboard_select_buttonButtonPushed(app, event)
            character(app); %打开键盘控制字符输入界面
        end

        % Key press function: UIFigure
        function UIFigureKeyPress(app, event)
            key = event.Key;  %储存按键状态
            if app.keyboard_select.Value %如果选中'键盘选择'
                switch key
                    case app.key_sale
                        if app.sale_people_allnum > 0 
                            %如果售票处等待人数大于0，则改变服务员状态为售票服务
                            app.server_state = 1; 
                        end
                    case app.key_ask
                        if app.ask_people_allnum > 0 
                            %如果现场咨询处等待人数大于0，则改变服务员状态为现场咨询服务
                            app.server_state = 2; 
                        end
                    case app.key_call
                        if app.call_people_allnum > 0 && ((app.sale_people_allnum + app.ask_people_allnum) == 0) 
                             %如果电话咨询处等待人数大于0并且售票处和现场咨询处均无人，则改变服务员状态为电话咨询服务
                            app.server_state = 3;
                        end
                end
            end
        end

        % Window button down function: UIFigure
        function UIFigureWindowButtonDown(app, event)
            %选中'鼠标选择'并且鼠标点击在灰黑色区域内
            if app.mouse_select.Value && app.UIFigure.CurrentPoint(1)>210 &&...
                    app.UIFigure.CurrentPoint(1)<910 && app.UIFigure.CurrentPoint(2)>5 &&...
                    app.UIFigure.CurrentPoint(2)<770
                origin_s = app.server_state; %保存原来的状态
                switch app.UIFigure.SelectionType
                    case 'normal' %左键
                        app.server_state = app.mouse_dir.left;
                    case 'alt'    %右键
                        app.server_state = app.mouse_dir.right;
                    case 'extend' %滚轮
                        app.server_state = app.mouse_dir.middle;
                end
                switch app.server_state
                    case 1
                        if ~app.sale_people_allnum 
                            %如果鼠标点击售票按键，但是售票无人等待，则继续保持原状态
                            app.server_state = origin_s;
                        end
                    case 2
                        if ~app.ask_people_allnum 
                            %如果鼠标点击现场咨询按键，但是现场咨询无人等待，则继续保持原状态
                            app.server_state = origin_s;
                        end
                    case 3
                        if (app.sale_people_allnum + app.ask_people_allnum) > 0 || app.call_people_allnum == 0
                            %如果鼠标点击电话咨询按键吗，但是售票或现场咨询有人或者电话咨询无人，则继续保持原状态
                            app.server_state = origin_s;
                        end
                end
            end
        end

        % Button pushed function: mouse_select_button
        function mouse_select_buttonButtonPushed(app, event)
            mouse(app); %打开鼠标按键选择界面
        end

        % Button pushed function: help_button
        function help_buttonButtonPushed(app, event)
            run help.mlapp; %打开使用帮助界面
        end

        % Button pushed function: all_io_data_button
        function all_io_data_buttonButtonPushed(app, event)
            app.subtable = all_io_data();
            app.subtable.UITable.Data = [app.subtable.UITable.Data;app.input_output];          
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.6549 0.651 0.6706];
            app.UIFigure.Position = [100 100 1159 777];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.WindowButtonDownFcn = createCallbackFcn(app, @UIFigureWindowButtonDown, true);
            app.UIFigure.KeyPressFcn = createCallbackFcn(app, @UIFigureKeyPress, true);
            app.UIFigure.HandleVisibility = 'on';

            % Create draw
            app.draw = uiaxes(app.UIFigure);
            app.draw.XLim = [0 100];
            app.draw.YLim = [-50 50];
            app.draw.XColor = 'none';
            app.draw.XTick = [0 10 20 30 40 50 60 70 80 90 100];
            app.draw.XTickLabelRotation = 0;
            app.draw.XTickLabel = '';
            app.draw.YColor = 'none';
            app.draw.YTickLabelRotation = 0;
            app.draw.YTickLabel = '';
            app.draw.ZTickLabelRotation = 0;
            app.draw.Color = 'none';
            app.draw.GridColor = [0.149 0.149 0.149];
            app.draw.Position = [204 12 506 746];

            % Create draw_2
            app.draw_2 = uiaxes(app.UIFigure);
            app.draw_2.XLim = [0 40];
            app.draw_2.YLim = [-50 50];
            app.draw_2.XColor = [0.502 0.502 0.502];
            app.draw_2.XTickLabelRotation = 0;
            app.draw_2.XTickLabel = '';
            app.draw_2.YColor = [0.502 0.502 0.502];
            app.draw_2.YTickLabelRotation = 0;
            app.draw_2.YTickLabel = '';
            app.draw_2.ZTickLabelRotation = 0;
            app.draw_2.Color = [0.502 0.502 0.502];
            app.draw_2.XGrid = 'on';
            app.draw_2.YGrid = 'on';
            app.draw_2.GridColor = [0.149 0.149 0.149];
            app.draw_2.Position = [697 3 238 774];

            % Create ask_people_bk
            app.ask_people_bk = uilabel(app.UIFigure);
            app.ask_people_bk.BackgroundColor = [0.7765 0.9216 0.6549];
            app.ask_people_bk.Position = [503 431 192 37];
            app.ask_people_bk.Text = '';

            % Create sale_people_bk
            app.sale_people_bk = uilabel(app.UIFigure);
            app.sale_people_bk.BackgroundColor = [0.7765 0.9216 0.6549];
            app.sale_people_bk.Position = [503 630 192 37];
            app.sale_people_bk.Text = '';

            % Create Panel_3
            app.Panel_3 = uipanel(app.UIFigure);
            app.Panel_3.ForegroundColor = [1 1 1];
            app.Panel_3.Title = '        模型输出';
            app.Panel_3.BackgroundColor = [0.749 0.6 0.5961];
            app.Panel_3.FontName = '楷体';
            app.Panel_3.FontSize = 20;
            app.Panel_3.Position = [917 188 242 588];

            % Create endButton
            app.endButton = uibutton(app.Panel_3, 'push');
            app.endButton.ButtonPushedFcn = createCallbackFcn(app, @endButtonPushed, true);
            app.endButton.BackgroundColor = [0.7294 0.2863 0.2941];
            app.endButton.Position = [19 43 86 49];
            app.endButton.Text = '仿真结束确认';

            % Create time
            app.time = uilabel(app.Panel_3);
            app.time.FontSize = 15;
            app.time.FontColor = [0.149 0.149 0.149];
            app.time.Position = [100 517 92 22];
            app.time.Text = '0';

            % Create time_label
            app.time_label = uilabel(app.Panel_3);
            app.time_label.FontSize = 15;
            app.time_label.FontColor = [0.149 0.149 0.149];
            app.time_label.Position = [22 517 80 22];
            app.time_label.Text = '实时时间：';

            % Create sale_period_label
            app.sale_period_label = uilabel(app.Panel_3);
            app.sale_period_label.FontSize = 18;
            app.sale_period_label.FontColor = [1 1 1];
            app.sale_period_label.Position = [17 456 222 23];
            app.sale_period_label.Text = '现场售票服务平均等待时间';

            % Create ask_period_label
            app.ask_period_label = uilabel(app.Panel_3);
            app.ask_period_label.FontSize = 18;
            app.ask_period_label.FontColor = [1 1 1];
            app.ask_period_label.Position = [17 367 222 23];
            app.ask_period_label.Text = '现场咨询服务平均等待时间';

            % Create call_period_label
            app.call_period_label = uilabel(app.Panel_3);
            app.call_period_label.FontSize = 18;
            app.call_period_label.FontColor = [1 1 1];
            app.call_period_label.Position = [17 277 222 23];
            app.call_period_label.Text = '电话咨询服务平均等待时间';

            % Create sale_period
            app.sale_period = uilabel(app.Panel_3);
            app.sale_period.BackgroundColor = [1 1 1];
            app.sale_period.FontSize = 18;
            app.sale_period.Position = [84 420 88 23];
            app.sale_period.Text = '';

            % Create ask_period
            app.ask_period = uilabel(app.Panel_3);
            app.ask_period.BackgroundColor = [1 1 1];
            app.ask_period.FontSize = 18;
            app.ask_period.Position = [84 327 88 23];
            app.ask_period.Text = '';

            % Create call_period
            app.call_period = uilabel(app.Panel_3);
            app.call_period.BackgroundColor = [1 1 1];
            app.call_period.FontSize = 18;
            app.call_period.Position = [84 230 88 23];
            app.call_period.Text = '';

            % Create sLabel
            app.sLabel = uilabel(app.Panel_3);
            app.sLabel.FontSize = 18;
            app.sLabel.Position = [182 420 25 23];
            app.sLabel.Text = 's';

            % Create sLabel_2
            app.sLabel_2 = uilabel(app.Panel_3);
            app.sLabel_2.FontSize = 18;
            app.sLabel_2.Position = [182 327 25 23];
            app.sLabel_2.Text = 's';

            % Create sLabel_3
            app.sLabel_3 = uilabel(app.Panel_3);
            app.sLabel_3.FontSize = 18;
            app.sLabel_3.Position = [182 230 25 23];
            app.sLabel_3.Text = 's';

            % Create server_occupy_label
            app.server_occupy_label = uilabel(app.Panel_3);
            app.server_occupy_label.FontSize = 18;
            app.server_occupy_label.FontColor = [1 1 1];
            app.server_occupy_label.Position = [17 173 222 23];
            app.server_occupy_label.Text = '服务员在工作时间的占用率';

            % Create server_occupy
            app.server_occupy = uilabel(app.Panel_3);
            app.server_occupy.BackgroundColor = [1 1 1];
            app.server_occupy.FontSize = 18;
            app.server_occupy.Position = [84 130 88 23];
            app.server_occupy.Text = '';

            % Create percent_label
            app.percent_label = uilabel(app.Panel_3);
            app.percent_label.FontSize = 18;
            app.percent_label.Position = [182 130 25 23];
            app.percent_label.Text = '%';

            % Create all_io_data_button
            app.all_io_data_button = uibutton(app.Panel_3, 'push');
            app.all_io_data_button.ButtonPushedFcn = createCallbackFcn(app, @all_io_data_buttonButtonPushed, true);
            app.all_io_data_button.BackgroundColor = [0.8196 0.6 0.2196];
            app.all_io_data_button.FontColor = [0.149 0.149 0.149];
            app.all_io_data_button.Position = [132 44 99 48];
            app.all_io_data_button.Text = {'模型总输入输出'; '参数表格'};

            % Create cinema
            app.cinema = uilabel(app.UIFigure);
            app.cinema.FontName = '楷体';
            app.cinema.FontSize = 30;
            app.cinema.FontColor = [1 1 1];
            app.cinema.Position = [514 726 95 49];
            app.cinema.Text = '电影院';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.ForegroundColor = [1 1 1];
            app.Panel.Title = '   初始条件设置';
            app.Panel.BackgroundColor = [0.749 0.6 0.5961];
            app.Panel.FontName = '楷体';
            app.Panel.FontSize = 20;
            app.Panel.Position = [0 3 205 775];

            % Create selectGroup
            app.selectGroup = uibuttongroup(app.Panel);
            app.selectGroup.SelectionChangedFcn = createCallbackFcn(app, @selectGroupSelectionChanged, true);
            app.selectGroup.Title = '服务员服务方式的选择';
            app.selectGroup.Position = [1 358 202 127];

            % Create system_select
            app.system_select = uiradiobutton(app.selectGroup);
            app.system_select.Text = '系统选择';
            app.system_select.Position = [11 79 70 22];
            app.system_select.Value = true;

            % Create keyboard_select
            app.keyboard_select = uiradiobutton(app.selectGroup);
            app.keyboard_select.Text = '键盘选择';
            app.keyboard_select.Position = [11 57 70 22];

            % Create button_select
            app.button_select = uiradiobutton(app.selectGroup);
            app.button_select.Text = '按钮选择';
            app.button_select.Position = [11 35 70 22];

            % Create keyboard_select_button
            app.keyboard_select_button = uibutton(app.selectGroup, 'push');
            app.keyboard_select_button.ButtonPushedFcn = createCallbackFcn(app, @keyboard_select_buttonButtonPushed, true);
            app.keyboard_select_button.BackgroundColor = [0.851 0.3255 0.098];
            app.keyboard_select_button.Position = [84 57 87 23];
            app.keyboard_select_button.Text = '输入控制字符';

            % Create mouse_select
            app.mouse_select = uiradiobutton(app.selectGroup);
            app.mouse_select.Text = '鼠标选择';
            app.mouse_select.Position = [11 12 70 22];

            % Create mouse_select_button
            app.mouse_select_button = uibutton(app.selectGroup, 'push');
            app.mouse_select_button.ButtonPushedFcn = createCallbackFcn(app, @mouse_select_buttonButtonPushed, true);
            app.mouse_select_button.BackgroundColor = [0.851 0.3255 0.098];
            app.mouse_select_button.Position = [84 12 87 23];
            app.mouse_select_button.Text = '输入控制按键';

            % Create keyboard_character
            app.keyboard_character = uipanel(app.Panel);
            app.keyboard_character.Title = '键盘选择对应字符';
            app.keyboard_character.Position = [1 235 202 103];

            % Create sale_label
            app.sale_label = uilabel(app.keyboard_character);
            app.sale_label.Position = [10 55 65 22];
            app.sale_label.Text = '现场售票：';

            % Create ask_label
            app.ask_label = uilabel(app.keyboard_character);
            app.ask_label.Position = [10 30 65 22];
            app.ask_label.Text = '现场咨询：';

            % Create call_label
            app.call_label = uilabel(app.keyboard_character);
            app.call_label.Position = [10 7 65 22];
            app.call_label.Text = '电话咨询：';

            % Create sale_character
            app.sale_character = uilabel(app.keyboard_character);
            app.sale_character.FontColor = [1 0 0];
            app.sale_character.Position = [70 55 25 22];
            app.sale_character.Text = 'a';

            % Create ask_character
            app.ask_character = uilabel(app.keyboard_character);
            app.ask_character.FontColor = [1 0 0];
            app.ask_character.Position = [69 30 25 22];
            app.ask_character.Text = 's';

            % Create call_character
            app.call_character = uilabel(app.keyboard_character);
            app.call_character.FontColor = [1 0 0];
            app.call_character.Position = [69 7 25 22];
            app.call_character.Text = 'd';

            % Create Lamp2
            app.Lamp2 = uilamp(app.keyboard_character);
            app.Lamp2.Position = [105 86 13 13];

            % Create start
            app.start = uibutton(app.Panel, 'push');
            app.start.ButtonPushedFcn = createCallbackFcn(app, @startButtonPushed, true);
            app.start.BackgroundColor = [0.7294 0.2863 0.2941];
            app.start.Position = [54 39 92 48];
            app.start.Text = '确认仿真开始';

            % Create Label_4
            app.Label_4 = uilabel(app.Panel);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.FontColor = [1 1 1];
            app.Label_4.Position = [37 702 95 22];
            app.Label_4.Text = '售票人员到达率';

            % Create sale_rate
            app.sale_rate = uieditfield(app.Panel, 'numeric');
            app.sale_rate.Position = [141 702 56 22];
            app.sale_rate.Value = 0.5;

            % Create Label_5
            app.Label_5 = uilabel(app.Panel);
            app.Label_5.HorizontalAlignment = 'right';
            app.Label_5.FontColor = [1 1 1];
            app.Label_5.Position = [37 663 95 22];
            app.Label_5.Text = '咨询人员到达率';

            % Create ask_rate
            app.ask_rate = uieditfield(app.Panel, 'numeric');
            app.ask_rate.Position = [141 663 56 22];
            app.ask_rate.Value = 0.8;

            % Create Label_6
            app.Label_6 = uilabel(app.Panel);
            app.Label_6.HorizontalAlignment = 'right';
            app.Label_6.FontColor = [1 1 1];
            app.Label_6.Position = [37 623 95 22];
            app.Label_6.Text = '电话人员到达率';

            % Create call_rate
            app.call_rate = uieditfield(app.Panel, 'numeric');
            app.call_rate.Position = [141 623 56 22];
            app.call_rate.Value = 1;

            % Create Label_11
            app.Label_11 = uilabel(app.Panel);
            app.Label_11.HorizontalAlignment = 'right';
            app.Label_11.FontColor = [1 1 1];
            app.Label_11.Position = [7 585 125 22];
            app.Label_11.Text = '现场售票服务时长参数';

            % Create sale_time_rate
            app.sale_time_rate = uieditfield(app.Panel, 'numeric');
            app.sale_time_rate.Position = [141 585 56 22];
            app.sale_time_rate.Value = 1;

            % Create Label_12
            app.Label_12 = uilabel(app.Panel);
            app.Label_12.HorizontalAlignment = 'right';
            app.Label_12.FontColor = [1 1 1];
            app.Label_12.Position = [7 542 125 22];
            app.Label_12.Text = '现场咨询服务时长参数';

            % Create ask_time_rate
            app.ask_time_rate = uieditfield(app.Panel, 'numeric');
            app.ask_time_rate.Position = [141 542 56 22];
            app.ask_time_rate.Value = 1;

            % Create Label_13
            app.Label_13 = uilabel(app.Panel);
            app.Label_13.HorizontalAlignment = 'right';
            app.Label_13.FontColor = [1 1 1];
            app.Label_13.Position = [5 504 125 22];
            app.Label_13.Text = '电话咨询服务时长参数';

            % Create call_time_rate
            app.call_time_rate = uieditfield(app.Panel, 'numeric');
            app.call_time_rate.Position = [139 504 56 22];
            app.call_time_rate.Value = 1;

            % Create mouse_button
            app.mouse_button = uipanel(app.Panel);
            app.mouse_button.Title = '鼠标选择对应按键';
            app.mouse_button.Position = [1 105 203 112];

            % Create sale_label2
            app.sale_label2 = uilabel(app.mouse_button);
            app.sale_label2.Position = [10 64 65 22];
            app.sale_label2.Text = '现场售票：';

            % Create ask_label2
            app.ask_label2 = uilabel(app.mouse_button);
            app.ask_label2.Position = [10 39 65 22];
            app.ask_label2.Text = '现场咨询：';

            % Create call_label2
            app.call_label2 = uilabel(app.mouse_button);
            app.call_label2.Position = [10 16 65 22];
            app.call_label2.Text = '电话咨询：';

            % Create sale_button
            app.sale_button = uilabel(app.mouse_button);
            app.sale_button.FontColor = [1 0 0];
            app.sale_button.Position = [69 64 37 22];
            app.sale_button.Text = 'left';

            % Create ask_button
            app.ask_button = uilabel(app.mouse_button);
            app.ask_button.FontColor = [1 0 0];
            app.ask_button.Position = [69 39 41 22];
            app.ask_button.Text = 'middle';

            % Create call_button
            app.call_button = uilabel(app.mouse_button);
            app.call_button.FontColor = [1 0 0];
            app.call_button.Position = [69 16 37 22];
            app.call_button.Text = 'right';

            % Create Lamp3
            app.Lamp3 = uilamp(app.mouse_button);
            app.Lamp3.Position = [105 95 13 13];

            % Create help_button
            app.help_button = uibutton(app.Panel, 'push');
            app.help_button.ButtonPushedFcn = createCallbackFcn(app, @help_buttonButtonPushed, true);
            app.help_button.Position = [1 1 63 23];
            app.help_button.Text = '使用帮助';

            % Create sale_people_allnum_label
            app.sale_people_allnum_label = uilabel(app.UIFigure);
            app.sale_people_allnum_label.FontSize = 15;
            app.sale_people_allnum_label.FontColor = [0.149 0.149 0.149];
            app.sale_people_allnum_label.Position = [514 637 125 22];
            app.sale_people_allnum_label.Text = '现场买票总人数：';

            % Create ask_people_allnum_label
            app.ask_people_allnum_label = uilabel(app.UIFigure);
            app.ask_people_allnum_label.FontSize = 15;
            app.ask_people_allnum_label.FontColor = [0.149 0.149 0.149];
            app.ask_people_allnum_label.Position = [514 439 125 22];
            app.ask_people_allnum_label.Text = '现场咨询总人数：';

            % Create sale_people_allnum_text
            app.sale_people_allnum_text = uilabel(app.UIFigure);
            app.sale_people_allnum_text.FontSize = 15;
            app.sale_people_allnum_text.FontColor = [1 0 0];
            app.sale_people_allnum_text.Position = [638 637 25 22];
            app.sale_people_allnum_text.Text = '0';

            % Create ask_people_allnum_text
            app.ask_people_allnum_text = uilabel(app.UIFigure);
            app.ask_people_allnum_text.FontSize = 15;
            app.ask_people_allnum_text.FontColor = [1 0 0];
            app.ask_people_allnum_text.Position = [638 439 25 22];
            app.ask_people_allnum_text.Text = '0';

            % Create call_people_bk
            app.call_people_bk = uilabel(app.UIFigure);
            app.call_people_bk.BackgroundColor = [0.7765 0.9216 0.6549];
            app.call_people_bk.Position = [502 210 192 37];
            app.call_people_bk.Text = '';

            % Create call_people_allnum_label
            app.call_people_allnum_label = uilabel(app.UIFigure);
            app.call_people_allnum_label.FontSize = 15;
            app.call_people_allnum_label.FontColor = [0.149 0.149 0.149];
            app.call_people_allnum_label.Position = [514 218 125 22];
            app.call_people_allnum_label.Text = '电话咨询总人数：';

            % Create call_people_allnum_text
            app.call_people_allnum_text = uilabel(app.UIFigure);
            app.call_people_allnum_text.FontSize = 15;
            app.call_people_allnum_text.FontColor = [1 0 0];
            app.call_people_allnum_text.Position = [638 218 25 22];
            app.call_people_allnum_text.Text = '0';

            % Create sale_label_button
            app.sale_label_button = uibutton(app.UIFigure, 'push');
            app.sale_label_button.ButtonPushedFcn = createCallbackFcn(app, @sale_label_buttonButtonPushed, true);
            app.sale_label_button.BackgroundColor = [0.7843 0.8 0.7569];
            app.sale_label_button.Position = [708 609 27 79];
            app.sale_label_button.Text = {'现'; '场'; '售'; '票'; '处'};

            % Create Lamp
            app.Lamp = uilamp(app.UIFigure);
            app.Lamp.Position = [661 219 20 20];

            % Create ask_label_button
            app.ask_label_button = uibutton(app.UIFigure, 'push');
            app.ask_label_button.ButtonPushedFcn = createCallbackFcn(app, @ask_label_buttonButtonPushed, true);
            app.ask_label_button.BackgroundColor = [0.7843 0.8 0.7569];
            app.ask_label_button.Position = [708 407 27 81];
            app.ask_label_button.Text = {'现'; '场'; '咨'; '询'; '处'};

            % Create call_label_button
            app.call_label_button = uibutton(app.UIFigure, 'push');
            app.call_label_button.ButtonPushedFcn = createCallbackFcn(app, @call_label_buttonButtonPushed, true);
            app.call_label_button.BackgroundColor = [0.7843 0.8 0.7569];
            app.call_label_button.Position = [708 189 25 81];
            app.call_label_button.Text = {'电'; '话'; '咨'; '询'; '处'};

            % Create gate_label
            app.gate_label = uilabel(app.UIFigure);
            app.gate_label.BackgroundColor = [0.9176 0.902 0.8706];
            app.gate_label.FontName = '楷体';
            app.gate_label.FontSize = 20;
            app.gate_label.Position = [204 297 25 211];
            app.gate_label.Text = {'入'; '口'};

            % Create server_area_label
            app.server_area_label = uilabel(app.UIFigure);
            app.server_area_label.BackgroundColor = [0.4667 0.6745 0.1882];
            app.server_area_label.FontSize = 20;
            app.server_area_label.FontColor = [1 1 1];
            app.server_area_label.Position = [765 723 102 25];
            app.server_area_label.Text = '  服务区域';

            % Create Panel_2
            app.Panel_2 = uipanel(app.UIFigure);
            app.Panel_2.Title = '        模型状态';
            app.Panel_2.BackgroundColor = [0.7765 0.9216 0.6549];
            app.Panel_2.FontName = '楷体';
            app.Panel_2.FontSize = 20;
            app.Panel_2.Position = [917 1 242 187];

            % Create all_people_num_label
            app.all_people_num_label = uilabel(app.Panel_2);
            app.all_people_num_label.FontSize = 15;
            app.all_people_num_label.FontColor = [0.149 0.149 0.149];
            app.all_people_num_label.Position = [13 110 95 22];
            app.all_people_num_label.Text = '影院总人数：';

            % Create all_people_num_text
            app.all_people_num_text = uilabel(app.Panel_2);
            app.all_people_num_text.FontSize = 15;
            app.all_people_num_text.FontColor = [1 0 0];
            app.all_people_num_text.Position = [107 110 25 22];
            app.all_people_num_text.Text = '0';

            % Create enter_people_num_label
            app.enter_people_num_label = uilabel(app.Panel_2);
            app.enter_people_num_label.FontSize = 15;
            app.enter_people_num_label.FontColor = [0.149 0.149 0.149];
            app.enter_people_num_label.Position = [7 69 125 22];
            app.enter_people_num_label.Text = '此刻进影院人数：';

            % Create enter_people_num_text
            app.enter_people_num_text = uilabel(app.Panel_2);
            app.enter_people_num_text.FontSize = 15;
            app.enter_people_num_text.FontColor = [1 0 0];
            app.enter_people_num_text.Position = [131 67 25 22];
            app.enter_people_num_text.Text = '0';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main

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