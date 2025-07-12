Texture2D src : register(t0);
cbuffer constant0 : register(b0) {
    float blurSize;
    float luminanceMode; // 0: 加重平均, 1: 平均, 2: 最大値
}

// RGBの輝度を計算
float pixel_value(float4 color) {
    float3 rgb = (color.a > 0.0) ? color.rgb / color.a : float3(0.0, 0.0, 0.0);

    float weighted = dot(rgb, float3(0.299, 0.587, 0.114));
    float average = (rgb.r + rgb.g + rgb.b) / 3.0;
    float maximum = max(rgb.r, max(rgb.g, rgb.b));

    float v0 = step(0.0, 0.5 - abs(luminanceMode - 0.0)) * weighted;
    float v1 = step(0.0, 0.5 - abs(luminanceMode - 1.0)) * average;
    float v2 = step(0.0, 0.5 - abs(luminanceMode - 2.0)) * maximum;

    return v0 + v1 + v2;
}

float4 kuwahara_naive(float4 pos : SV_Position) : SV_Target {
    int2 ipos = int2(pos.xy);
    uint uw, uh;
    src.GetDimensions(uw, uh);
    int w = int(uw);
    int h = int(uh);
    int2 bottomRight = int2(w - 1, h - 1);
    int bs = int(blurSize);
    float n = (blurSize + 1) * (blurSize + 1);

    int2 offset[4] = {
        int2(-bs, -bs),
        int2(0, -bs),
        int2(-bs, 0),
        int2(0, 0)
    };
    float4 color[4] = {
        float4(0, 0, 0, 0),
        float4(0, 0, 0, 0),
        float4(0, 0, 0, 0),
        float4(0, 0, 0, 0)
    };
    float2 value[4] = {
        float2(0, 0),
        float2(0, 0),
        float2(0, 0),
        float2(0, 0)
    };

    // 4領域のサンプリング
    for (int i = 0; i < 4; i++) {
        for (int y = 0; y <= blurSize; y++) {
            for (int x = 0; x <= blurSize; x++) {
                int2 samplePos = clamp(ipos + offset[i] + int2(x, y), int2(0, 0), bottomRight);
                float4 sampleColor = src[samplePos];
                color[i] += sampleColor;
                float v = pixel_value(sampleColor);
                value[i] += float2(v, v * v);
            }
        }
    }

    // 平均・分散の計算
    float var[4];
    for (int j = 0; j < 4; j++) {
        color[j] /= n;
        value[j] /= n;
        var[j] = value[j].y - value[j].x * value[j].x;
    }

    // 最小分散の領域を選択
    float4 result = color[0];
    float min_var = var[0];
    for (int k = 1; k < 4; k++) {
        result = lerp(result, color[k], step(var[k], min_var));
        min_var = min(min_var, var[k]);
    }

    return result;
}
