#version 330 core
#define PASS_COUNT 1

out vec4 FragColor;
in vec2 TexCoords;

float fBrightness=2.5;
float fSteps=222.;
float fParticleSize=.015;
float fParticleLength=.5/60.;
float fMinDist=.8;
float fMaxDist=5.;
float fRepeatMin=1.;
float fRepeatMax=2.;
float fDepthFade=1.2;

uniform vec2 position;

uniform sampler2D tex;
uniform vec2 canvasResolution;
uniform vec2 displayResolution;
uniform vec2 scale;
uniform float time;
const float sharpness=2.;

float Random(float x)
{
    return fract(sin(x*123.456)*23.4567+sin(x*345.678)*45.6789+sin(x*456.789)*56.789);
}

vec3 GetParticleColour(const in vec3 vParticlePos,const in float fParticleSize,const in vec3 vRayDir)
{
    vec2 vNormDir=normalize(vRayDir.xy);
    float d1=dot(vParticlePos.xy,vNormDir.xy)/length(vRayDir.xy);
    vec3 vClosest2d=vRayDir*d1;
    
    vec3 vClampedPos=vParticlePos;
    
    vClampedPos.z=clamp(vClosest2d.z,vParticlePos.z-fParticleLength,vParticlePos.z+fParticleLength);
    
    float d=dot(vClampedPos,vRayDir);
    
    vec3 vClosestPos=vRayDir*d;
    
    vec3 vDeltaPos=vClampedPos-vClosestPos;
    
    float fClosestDist=length(vDeltaPos)/fParticleSize;
    
    float fShade=clamp(1.-fClosestDist,0.,1.);
    
    fShade=fShade*exp2(-d*fDepthFade)*fBrightness;
    
    return vec3(fShade);
}

vec3 GetParticlePos(const in vec3 vRayDir,const in float fZPos,const in float fSeed)
{
    float fAngle=atan(vRayDir.x,vRayDir.y);
    float fAngleFraction=fract(fAngle/(3.14*2.));
    
    float fSegment=floor(fAngleFraction*fSteps+fSeed)+.5-fSeed;
    float fParticleAngle=fSegment/fSteps*(3.14*2.);
    
    float fSegmentPos=fSegment/fSteps;
    float fRadius=fMinDist+Random(fSegmentPos+fSeed)*(fMaxDist-fMinDist);
    
    float tunnelZ=vRayDir.z/length(vRayDir.xy/fRadius);
    
    tunnelZ+=fZPos;
    
    float fRepeat=fRepeatMin+Random(fSegmentPos+.1+fSeed)*(fRepeatMax-fRepeatMin);
    
    float fParticleZ=(ceil(tunnelZ/fRepeat)-.5)*fRepeat-fZPos;
    
    return vec3(sin(fParticleAngle)*fRadius,cos(fParticleAngle)*fRadius,fParticleZ);
}

vec3 Starfield(const in vec3 vRayDir,const in float fZPos,const in float fSeed)
{
    vec3 vParticlePos=GetParticlePos(vRayDir,fZPos,fSeed);
    return GetParticleColour(vParticlePos,fParticleSize,vRayDir);
}

float sharpen(float pix_coord){
    float norm=(fract(pix_coord)-.5)*2.;
    float norm2=norm*norm;
    return floor(pix_coord)+norm*pow(norm2,sharpness)/2.+.5;
}

void main(){
    vec2 uv=TexCoords.xy;
    
    vec2 vScreenPos=uv*2.-1.;
    vScreenPos.x*=canvasResolution.x/canvasResolution.y;
    
    vec3 vRayDir=normalize(vec3(vScreenPos,1.));
    
    float fShade=0.;
    
    float fZPos=5.+time;
    
    fParticleLength=.00001;
    
    float fSeed=0.;
    
    vec3 vResult=mix(vec3(0.),vec3(0.),vRayDir.y*.5+.5);
    
    for(int i=0;i<PASS_COUNT;i++)
    {
        vResult+=Starfield(vRayDir,fZPos,fSeed);
        fSeed+=1.234;
    }
    
    vec4 resultA=vec4(sqrt(vResult),1.);
    resultA+=texture(tex,vec2(sharpen(uv.x*canvasResolution.x)/canvasResolution.x,sharpen(uv.y*canvasResolution.y)/canvasResolution.y));
    
    FragColor=resultA;
}