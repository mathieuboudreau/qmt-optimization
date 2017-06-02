function plotJacobianColumns(jacobianObject, varargin)
%PLOTJACOBIANCOLUMNS Plots the qMT Jacobian columns, seperate figures for
%each columns. 
%
%   Plots the qMT Jacobian columns, seperate figures for each columns.
%   In each plot, seperate curves will be plotted for each unique MT 
%   flip-angle in the protocol.
%   
%   --args--
%   jacobianObject: Object. Is a subclass of the SeqJacobian class.
%   varargin: {1} - String flag to choose between plotting real or 
%                   absolute values. Can be either 'real' or 'abs'.
%

    % Prepare get Jacobian details
    jacobianStruct = jacobianObject.getJacobianStruct;
    jacobianMat = jacobianStruct.jacobianMatrix;

    % Each line plotted will be unique to each flip angle
    flipAngles = unique(jacobianStruct.protocol(:,1)); % First column of protocol should be MT FAs for all jacobian rows.

    if nargin>1
        plotOpts = varargin{1};
        
        if isfield(plotOpts, 'lineStyle')
            lineStyle = plotOpts.lineStyle;
        end
        
        if isfield(plotOpts, 'colorMode')
            colorMode = plotOpts.colorMode;
            switch colorMode
                case 'default'
                case 'rainbow'
                    lineColors = linspecer(length(flipAngles));
                otherwise
                    error('plotJacobianColumns:unkownColorMode', 'The colorMode specified by the plot options is unkown');
            end
        end
    else
        lineStyle = '-o'; 
        colorMode = 'default';
    end
    
    
    for paramsIndex = 1:length(jacobianStruct.paramsKeys)
        structHandler.figure = figure();
        
        for faIndex = 1:length(flipAngles)
            offsetIndices = find(jacobianStruct.protocol(:,1)==flipAngles(faIndex));
            offsetValues = jacobianStruct.protocol(offsetIndices,2);
            
            yValues = jacobianMat(offsetIndices, paramsIndex);
            
            if nargin>1
               plotOpts = varargin{1};
               if isfield(plotOpts, 'dataMode')          
                    switch plotOpts.dataMode
                        case 'real'
                            continue
                        case 'abs'
                            yValues = abs(jacobianMat(offsetIndices, paramsIndex));
                        otherwise
                    end
               end
            end
            
            switch colorMode
                case 'default'
                    colorOrder = get(gca, 'ColorOrder');
                    nextColor = colorOrder(mod(length(get(gca, 'Children')), size(colorOrder, 1))+1, :);
                case 'rainbow'
                    nextColor = lineColors(faIndex,:);
            end
            
            semilogx(offsetValues, yValues, lineStyle, 'Color', nextColor, 'LineWidth', 2 ,'MarkerSize', 10);
            hold on
        end
        
        structHandler.xlabel = xlabel('offset freq. (Hz)');
        structHandler.ylabel = ylabel(jacobianStruct.paramsKeys(paramsIndex));

        for faIndex = 1:length(flipAngles)
            legend_FA{faIndex} = num2str(flipAngles(faIndex));
        end

        structHandler.legend = legend(legend_FA);

        figureProperties_plot(structHandler)
        hold off
    end

end
