import { cn } from "./utils";

interface GradientBgProps {
  variant?: "primary" | "secondary" | "accent" | "hero";
  className?: string;
  children: React.ReactNode;
}

export function GradientBg({ variant = "primary", className, children }: GradientBgProps) {
  const variants = {
    primary: "bg-gradient-to-br from-primary/5 via-[#FF6B35]/10 to-[#1E88E5]/10",
    secondary: "bg-gradient-to-br from-gray-50/50 via-white to-[#1E88E5]/5",
    accent: "bg-gradient-to-br from-white via-gray-50/50 to-white",
    hero: "bg-gradient-to-br from-primary/5 via-[#FF6B35]/10 to-[#1E88E5]/10"
  };

  return (
    <div className={cn(variants[variant], "relative overflow-hidden", className)}>
      {children}
    </div>
  );
}