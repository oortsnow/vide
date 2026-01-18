local typeof = game and typeof or require("../test/mock").typeof :: never
local Instance = game and Instance or require("../test/mock").Instance :: never

local apply = require("./apply")
local defaults = require("./defaults")
local flags = require("./flags")

local ctor_cache = {} :: { [string]: (AnyProps) -> Instance }
local function lazy_init(_, class: string)
	local function ctor(properties: AnyProps): Instance
		local ok, instance: Instance = pcall(Instance.new, class :: any)
		if not ok then
			error(`invalid class name {class}`, 0)
		end

		if flags.defaults then
			local default: { [string]: unknown }? = defaults[class]
			if default then
				for i, v in default do
					(instance :: any)[i] = v
				end
			end
		end

		return apply(instance, properties)
	end

	ctor_cache[class] = ctor
	return ctor
end
setmetatable(ctor_cache, { __index = lazy_init })

-- todo: remove support for different overloads
local function create(class_or_instance: string | Instance, properties: AnyProps?): ((AnyProps) -> Instance) | Instance
	if type(class_or_instance) ~= "string" and typeof(class_or_instance) ~= "Instance" then
		error("bad argument #1, expected string or instance, got " .. typeof(class_or_instance), 0)
	end

	local ctor = if type(class_or_instance) == "string"
		then ctor_cache[class_or_instance]
		else function(properties)
			local clone = class_or_instance:Clone()
			if not clone then
				error("attempt to clone a non-archivable instance")
			end
			return apply(clone, properties)
		end

	return if properties then ctor(properties) else ctor
end

export type CreatableInstances = {
	Accessory: Accessory,
	AccessoryDescription: AccessoryDescription,
	Accoutrement: Accoutrement,
	Actor: Actor,
	AdGui: AdGui,
	AdPortal: AdPortal,
	AirController: AirController,
	AlignOrientation: AlignOrientation,
	AlignPosition: AlignPosition,
	AngularVelocity: AngularVelocity,
	Animation: Animation,
	AnimationConstraint: AnimationConstraint,
	AnimationController: AnimationController,
	AnimationGraphDefinition: AnimationGraphDefinition,
	AnimationNodeDefinition: AnimationNodeDefinition,
	AnimationRigData: AnimationRigData,
	Animator: Animator,
	Annotation: Annotation,
	ArcHandles: ArcHandles,
	Atmosphere: Atmosphere,
	AtmosphereSensor: AtmosphereSensor,
	Attachment: Attachment,
	AudioAnalyzer: AudioAnalyzer,
	AudioChannelMixer: AudioChannelMixer,
	AudioChannelSplitter: AudioChannelSplitter,
	AudioChorus: AudioChorus,
	AudioCompressor: AudioCompressor,
	AudioDeviceInput: AudioDeviceInput,
	AudioDeviceOutput: AudioDeviceOutput,
	AudioDistortion: AudioDistortion,
	AudioEcho: AudioEcho,
	AudioEmitter: AudioEmitter,
	AudioEqualizer: AudioEqualizer,
	AudioFader: AudioFader,
	AudioFilter: AudioFilter,
	AudioFlanger: AudioFlanger,
	AudioGate: AudioGate,
	AudioLimiter: AudioLimiter,
	AudioListener: AudioListener,
	AudioPitchShifter: AudioPitchShifter,
	AudioPlayer: AudioPlayer,
	AudioRecorder: AudioRecorder,
	AudioReverb: AudioReverb,
	AudioSearchParams: AudioSearchParams,
	AudioSpeechToText: AudioSpeechToText,
	AudioTextToSpeech: AudioTextToSpeech,
	AudioTremolo: AudioTremolo,
	AuroraScript: AuroraScript,
	AvatarAccessoryRules: AvatarAccessoryRules,
	AvatarAnimationRules: AvatarAnimationRules,
	AvatarBodyRules: AvatarBodyRules,
	AvatarClothingRules: AvatarClothingRules,
	AvatarCollisionRules: AvatarCollisionRules,
	AvatarRules: AvatarRules,
	Backpack: Backpack,
	BallSocketConstraint: BallSocketConstraint,
	Beam: Beam,
	BillboardGui: BillboardGui,
	BindableEvent: BindableEvent,
	BindableFunction: BindableFunction,
	BlockMesh: BlockMesh,
	BloomEffect: BloomEffect,
	BlurEffect: BlurEffect,
	BodyAngularVelocity: BodyAngularVelocity,
	BodyColors: BodyColors,
	BodyForce: BodyForce,
	BodyGyro: BodyGyro,
	BodyPartDescription: BodyPartDescription,
	BodyPosition: BodyPosition,
	BodyThrust: BodyThrust,
	BodyVelocity: BodyVelocity,
	Bone: Bone,
	BoolValue: BoolValue,
	BoxHandleAdornment: BoxHandleAdornment,
	Breakpoint: Breakpoint,
	BrickColorValue: BrickColorValue,
	BubbleChatMessageProperties: BubbleChatMessageProperties,
	BuoyancySensor: BuoyancySensor,
	Camera: Camera,
	CanvasGroup: CanvasGroup,
	CFrameValue: CFrameValue,
	CharacterMesh: CharacterMesh,
	ChorusSoundEffect: ChorusSoundEffect,
	ClickDetector: ClickDetector,
	ClimbController: ClimbController,
	Clouds: Clouds,
	Color3Value: Color3Value,
	ColorCorrectionEffect: ColorCorrectionEffect,
	ColorGradingEffect: ColorGradingEffect,
	CompositeValueCurve: CompositeValueCurve,
	CompressorSoundEffect: CompressorSoundEffect,
	ConeHandleAdornment: ConeHandleAdornment,
	Configuration: Configuration,
	ControllerManager: ControllerManager,
	ControllerPartSensor: ControllerPartSensor,
	CornerWedgePart: CornerWedgePart,
	CurveAnimation: CurveAnimation,
	CustomLog: CustomLog,
	CylinderHandleAdornment: CylinderHandleAdornment,
	CylinderMesh: CylinderMesh,
	CylindricalConstraint: CylindricalConstraint,
	DataStoreGetOptions: DataStoreGetOptions,
	DataStoreIncrementOptions: DataStoreIncrementOptions,
	DataStoreOptions: DataStoreOptions,
	DataStoreSetOptions: DataStoreSetOptions,
	Decal: Decal,
	DepthOfFieldEffect: DepthOfFieldEffect,
	Dialog: Dialog,
	DialogChoice: DialogChoice,
	DistortionSoundEffect: DistortionSoundEffect,
	DoubleConstrainedValue: DoubleConstrainedValue,
	DragDetector: DragDetector,
	Dragger: Dragger,
	EchoSoundEffect: EchoSoundEffect,
	EqualizerSoundEffect: EqualizerSoundEffect,
	EulerRotationCurve: EulerRotationCurve,
	ExperienceInviteOptions: ExperienceInviteOptions,
	ExplorerFilter: ExplorerFilter,
	Explosion: Explosion,
	FaceControls: FaceControls,
	FileMesh: FileMesh,
	Fire: Fire,
	FlangeSoundEffect: FlangeSoundEffect,
	FloatCurve: FloatCurve,
	FloorWire: FloorWire,
	FluidForceSensor: FluidForceSensor,
	Folder: Folder,
	ForceField: ForceField,
	Frame: Frame,
	GetTextBoundsParams: GetTextBoundsParams,
	Glue: Glue,
	GroundController: GroundController,
	Handles: Handles,
	HandRigDescription: HandRigDescription,
	HapticEffect: HapticEffect,
	Hat: Hat,
	HiddenSurfaceRemovalAsset: HiddenSurfaceRemovalAsset,
	Highlight: Highlight,
	HingeConstraint: HingeConstraint,
	Hole: Hole,
	Humanoid: Humanoid,
	HumanoidController: HumanoidController,
	HumanoidDescription: HumanoidDescription,
	HumanoidRigDescription: HumanoidRigDescription,
	IKControl: IKControl,
	ImageButton: ImageButton,
	ImageHandleAdornment: ImageHandleAdornment,
	ImageLabel: ImageLabel,
	InputAction: InputAction,
	InputBinding: InputBinding,
	InputContext: InputContext,
	IntConstrainedValue: IntConstrainedValue,
	InternalSyncItem: InternalSyncItem,
	IntersectOperation: IntersectOperation,
	IntValue: IntValue,
	Keyframe: Keyframe,
	KeyframeMarker: KeyframeMarker,
	KeyframeSequence: KeyframeSequence,
	LinearVelocity: LinearVelocity,
	LineForce: LineForce,
	LineHandleAdornment: LineHandleAdornment,
	LocalizationTable: LocalizationTable,
	LocalScript: LocalScript,
	MakeupDescription: MakeupDescription,
	ManualGlue: ManualGlue,
	ManualWeld: ManualWeld,
	MarkerCurve: MarkerCurve,
	MaterialVariant: MaterialVariant,
	MeshPart: MeshPart,
	Model: Model,
	ModuleScript: ModuleScript,
	Motor: Motor,
	Motor6D: Motor6D,
	MotorFeature: MotorFeature,
	NegateOperation: NegateOperation,
	NoCollisionConstraint: NoCollisionConstraint,
	Noise: Noise,
	NumberPose: NumberPose,
	NumberValue: NumberValue,
	ObjectValue: ObjectValue,
	OperationGraph: OperationGraph,
	Pants: Pants,
	Part: Part,
	ParticleEmitter: ParticleEmitter,
	PartOperation: PartOperation,
	Path2D: Path2D,
	PathfindingLink: PathfindingLink,
	PathfindingModifier: PathfindingModifier,
	PitchShiftSoundEffect: PitchShiftSoundEffect,
	Plane: Plane,
	PlaneConstraint: PlaneConstraint,
	PluginAction: PluginAction,
	PluginCapabilities: PluginCapabilities,
	PointLight: PointLight,
	Pose: Pose,
	PrismaticConstraint: PrismaticConstraint,
	ProximityPrompt: ProximityPrompt,
	PyramidHandleAdornment: PyramidHandleAdornment,
	RayValue: RayValue,
	RelativeGui: RelativeGui,
	RemoteEvent: RemoteEvent,
	RemoteFunction: RemoteFunction,
	RenderingTest: RenderingTest,
	ReverbSoundEffect: ReverbSoundEffect,
	RigidConstraint: RigidConstraint,
	RocketPropulsion: RocketPropulsion,
	RodConstraint: RodConstraint,
	RopeConstraint: RopeConstraint,
	Rotate: Rotate,
	RotateP: RotateP,
	RotateV: RotateV,
	RotationCurve: RotationCurve,
	RTAnimationTracker: RTAnimationTracker,
	ScreenGui: ScreenGui,
	Script: Script,
	ScrollingFrame: ScrollingFrame,
	Seat: Seat,
	SelectionBox: SelectionBox,
	SelectionPartLasso: SelectionPartLasso,
	SelectionPointLasso: SelectionPointLasso,
	SelectionSphere: SelectionSphere,
	Shirt: Shirt,
	ShirtGraphic: ShirtGraphic,
	SkateboardController: SkateboardController,
	SkateboardPlatform: SkateboardPlatform,
	Sky: Sky,
	Smoke: Smoke,
	Snap: Snap,
	Sound: Sound,
	SoundGroup: SoundGroup,
	Sparkles: Sparkles,
	SpawnLocation: SpawnLocation,
	SpecialMesh: SpecialMesh,
	SphereHandleAdornment: SphereHandleAdornment,
	SpotLight: SpotLight,
	SpringConstraint: SpringConstraint,
	StarterGear: StarterGear,
	StringValue: StringValue,
	StudioAttachment: StudioAttachment,
	StudioCallout: StudioCallout,
	StyleDerive: StyleDerive,
	StyleLink: StyleLink,
	StyleQuery: StyleQuery,
	StyleRule: StyleRule,
	StyleSheet: StyleSheet,
	SunRaysEffect: SunRaysEffect,
	SurfaceAppearance: SurfaceAppearance,
	SurfaceGui: SurfaceGui,
	SurfaceLight: SurfaceLight,
	SurfaceSelection: SurfaceSelection,
	SwimController: SwimController,
	Team: Team,
	TeleportOptions: TeleportOptions,
	TerrainDetail: TerrainDetail,
	TerrainRegion: TerrainRegion,
	TextBox: TextBox,
	TextButton: TextButton,
	TextChannel: TextChannel,
	TextChatCommand: TextChatCommand,
	TextChatMessageProperties: TextChatMessageProperties,
	TextGenerator: TextGenerator,
	TextLabel: TextLabel,
	Texture: Texture,
	Tool: Tool,
	Torque: Torque,
	TorsionSpringConstraint: TorsionSpringConstraint,
	TrackerStreamAnimation: TrackerStreamAnimation,
	Trail: Trail,
	TremoloSoundEffect: TremoloSoundEffect,
	TrussPart: TrussPart,
	UIAspectRatioConstraint: UIAspectRatioConstraint,
	UICorner: UICorner,
	UIDragDetector: UIDragDetector,
	UIFlexItem: UIFlexItem,
	UIGradient: UIGradient,
	UIGridLayout: UIGridLayout,
	UIListLayout: UIListLayout,
	UIPadding: UIPadding,
	UIPageLayout: UIPageLayout,
	UIScale: UIScale,
	UISizeConstraint: UISizeConstraint,
	UIStroke: UIStroke,
	UITableLayout: UITableLayout,
	UITextSizeConstraint: UITextSizeConstraint,
	UnionOperation: UnionOperation,
	UniversalConstraint: UniversalConstraint,
	UnreliableRemoteEvent: UnreliableRemoteEvent,
	ValueCurve: ValueCurve,
	Vector3Curve: Vector3Curve,
	Vector3Value: Vector3Value,
	VectorForce: VectorForce,
	VehicleController: VehicleController,
	VehicleSeat: VehicleSeat,
	VelocityMotor: VelocityMotor,
	VideoDeviceInput: VideoDeviceInput,
	VideoDisplay: VideoDisplay,
	VideoFrame: VideoFrame,
	VideoPlayer: VideoPlayer,
	ViewportFrame: ViewportFrame,
	VisualizationMode: VisualizationMode,
	VisualizationModeCategory: VisualizationModeCategory,
	WedgePart: WedgePart,
	Weld: Weld,
	WeldConstraint: WeldConstraint,
	Wire: Wire,
	WireframeHandleAdornment: WireframeHandleAdornment,
	WorkspaceAnnotation: WorkspaceAnnotation,
	WorldModel: WorldModel,
	WrapDeformer: WrapDeformer,
	WrapLayer: WrapLayer,
	WrapTarget: WrapTarget,
	WrapTextureTransfer: WrapTextureTransfer,
}

type function get_instance_properties(instance_name: type, instances: type, instance_type: type)
	local instance = types.never

	local nil_type = types.singleton(nil)

	for key, value in instances:properties() do
		if key:value() == instance_name:value() and value.read then
			instance = value.read
		end
	end

	if instance == types.never then
		return types.never
	end

	local vide_props = types.newtable()

	local function get_properties(instance: type)
		local parent = instance:readparent()
		if parent ~= nil then
			get_properties(parent)
		end

		for index, value in instance:properties() do
			if value.read then
				if value.read:is("function") or value.read:is("intersection") then
					continue
				end
			end

			local connector = value.read
				and value.read.tag == "table"
				and value.read:readproperty(types.singleton("Connect"))
			if connector then
				local params = connector:parameters().head
				if not params then
					continue
				end
				local listener = params[2]
				if not listener then
					continue
				end
				vide_props:setproperty(index, types.optional(listener))
			elseif value.write then
				vide_props:setproperty(
					index,
					types.optional(types.unionof(value.write, types.newfunction({}, { head = { value.write } })))
				)
			end
		end
	end
	get_properties(instance)

	local vide_action = types.newtable({
		[types.singleton("priority")] = types.number,
		[types.singleton("callback")] = types.newfunction({ head = { instance } }),
	})

	local function_returns = types.newfunction()
	function_returns:setreturns({ types.unionof(instance_type, types.newtable()) })
	local indexing_table = types.newtable()
	indexing_table:setindexer(types.number, types.unionof(instance_type, function_returns))

	vide_props:setindexer(
		types.number,
		types.unionof(vide_props, vide_action, function_returns, instance_type, nil_type)
	)

	return vide_props
end

type function get_instance(instance_name: type, instances: type)
	for key, value in instances:properties() do
		if key:value() == instance_name:value() then
			return value.read
		end
	end

	error("Invalid class name", 0)
end

return (create :: any) :: <T>(
	className: keyof<CreatableInstances> | T
) -> (props: get_instance_properties<T, CreatableInstances, Instance>) -> get_instance<T, CreatableInstances>
