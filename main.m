%_______________________________________________________________________________________
%  AOA Batch Run Script (F1 - F23)
%  此腳本會一次執行所有測試函數，繪製收斂曲線並列印最佳解。
%_______________________________________________________________________________________

clear all 
clc

Solution_no = 30;   % 搜尋代理人數量 (依照您的需求調整，原為20或30)
M_Iter = 1000;      % 最大迭代次數

% 建立一個圖形視窗來畫收斂曲線
figure('Name', 'All Functions Convergence Curves', 'Color', 'w');

% 用來儲存結果的變數
All_Results = struct('Function', {}, 'Best_Score', {}, 'Best_Position', {});

disp('開始執行 F1 到 F23 ... 請稍候');

for i = 1:23
    % 1. 設定函數名稱 (F1, F2, ..., F23)
    F_name = ['F', num2str(i)];
    
    % 2. 取得函數資訊
    [LB, UB, Dim ,F_obj] = Get_F(F_name);
    
    
    % 3. 執行 AOA 演算法
    [Best_FF, Best_P, Conv_curve] = AOA(Solution_no, M_Iter, LB, UB, Dim, F_obj);
    
    % 4. 儲存結果
    All_Results(i).Function = F_name;
    All_Results(i).Best_Score = Best_FF;
    All_Results(i).Best_Position = Best_P;
    
    % 5. 繪製收斂曲線 (使用 Subplot 排列)
    % 安排成 5 列 5 行的網格 (共 25格，足夠放 23 個圖)
    subplot(5, 5, i);
    semilogy(Conv_curve, 'Color', 'r', 'LineWidth', 1.5);
    title(F_name);
    axis tight;
    grid on;
    
    % 為了版面整潔，只在特定位置顯示軸標籤
    if i > 20 
        xlabel('Iter'); 
    end
    if mod(i, 5) == 1 
        ylabel('Fitness'); 
    end
    
    % 在指令視窗顯示進度
    fprintf('Function %s Done. Best Score: %e\n', F_name, Best_FF);
end

% 調整圖形標題
sgtitle('Convergence Curves for All Benchmark Functions (F1-F23)');

% 6. 最後一次印出所有函數的最佳解表格
disp('-------------------------------------------------------');
disp('           AOA Optimization Results Summary            ');
disp('-------------------------------------------------------');
fprintf('%-10s | %-25s\n', 'Function', 'Best Fitness Score');
disp('-------------------------------------------------------');

for i = 1:23
    % 使用 %e 科學記號顯示，因為數值差異可能很大
    fprintf('%-10s | %-25.6e\n', All_Results(i).Function, All_Results(i).Best_Score);
end
disp('-------------------------------------------------------');
        



