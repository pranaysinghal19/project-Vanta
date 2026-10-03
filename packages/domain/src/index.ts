export type GoalDirection = 'reduce' | 'build';
export type EnforcementMode = 'track' | 'nudge' | 'protect';
export type GoalStatus = 'draft' | 'active' | 'paused' | 'completed' | 'archived';

export type GoalCategory =
  | 'pornography'
  | 'pmo'
  | 'masturbation'
  | 'paid_adult_content'
  | 'late_night_browsing'
  | 'social_media'
  | 'sleep'
  | 'exercise'
  | 'outdoors'
  | 'reading'
  | 'focus'
  | 'savings'
  | 'social'
  | 'custom';

export interface Goal {
  id: string;
  category: GoalCategory;
  direction: GoalDirection;
  title: string;
  status: GoalStatus;
  enforcement: EnforcementMode;
  target: Record<string, unknown>;
  replacementGoalIds: string[];
  startsAt: string;
  endsAt?: string;
}

export interface DeviceRule {
  id: string;
  deviceId: string;
  goalId: string;
  enforcement: EnforcementMode;
  schedule?: {
    timezone: string;
    start?: string;
    end?: string;
    days?: number[];
  };
}

export type DecisionLockState = 'active' | 'cooling_off' | 'confirmable' | 'changed' | 'cancelled';

export interface DecisionLockRequest {
  id: string;
  memberId: string;
  ruleId: string;
  requestedAt: string;
  confirmableAt: string;
  state: DecisionLockState;
}

export interface GuideCallSummary {
  id: string;
  scheduledAt: string;
  status: 'scheduled' | 'completed' | 'missed' | 'cancelled';
  durationSeconds?: number;
  /** No audio or transcript field by design. */
}

export interface Challenge {
  id: string;
  title: string;
  description: string;
  verification: 'trust' | 'system' | 'device' | 'partner';
  target: Record<string, unknown>;
}
