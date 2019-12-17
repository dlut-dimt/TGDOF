function [res_TGDOF] = process_TGDOF(y, mask, input_zf, IterNum, rho, MinNet, MaxNet, ArtifactsModels, L, lambda, useGPU);

    ArtifactsLevel      = logspace(log10(MaxNet),log10(MinNet),IterNum);
    ns                  = min(25,max(ceil(ArtifactsLevel/2),1)) ;
    ns                  = [ns(1)-1,ns];
     
    denom               = zeros(size(y)) ; 
    denom(logical(mask))= 1;        
    denom(denom == 0)   = 1e-6;  
    
    if useGPU
        input_zf        = gpuArray(input_zf);
        input_zf        = gpuArray(input_zf);
    end

    for itern = 1:IterNum
        
       %% automatically choose a propoer denoising network for artifacts removal
        if ns(itern+1)~=ns(itern)
            net.layers = [ArtifactsModels{min(25,max(ceil(ArtifactsLevel(itern)/2),1))}];    
            net = vl_simplenn_tidy(net);
            if useGPU
                net = vl_simplenn_move(net, 'gpu'); 
            end
        end
        
       %% Perform the proposed TGDOF algorithm to reconstruct the MR data
        input_zf = inner_process_TGDOF(y, mask, denom, input_zf, rho, net, L, lambda);
        
    end
    
    if useGPU
        input_zf = gather(input_zf);
    end
    
    res_TGDOF = input_zf;
end









